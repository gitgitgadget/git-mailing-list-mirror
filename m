From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Tue, 12 Nov 2013 17:20:46 -0600
Message-ID: <5282b7cdf3b12_1d45133de74b8@nysa.notmuch>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
 <1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
 <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
 <5281DB46.2010004@bbn.com>
 <5282977b2ecd_3b98795e785e@nysa.notmuch>
 <xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 00:28:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgNNs-0001O1-ET
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 00:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193Ab3KLX2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 18:28:33 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:43116 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab3KLX2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 18:28:31 -0500
Received: by mail-oa0-f45.google.com with SMTP id m1so4725956oag.18
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 15:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=rIVlPuxP9PMAKYJrNFsZ6H2keLw8dlvp6R0HX5qaEzQ=;
        b=XheRXdQGwCIZt8+O9Dbylr078zSb79uPObCCAJ9LghQE1p3l9JkVvi/T4ByES9/ieF
         9k7l93LrUgpO2tCwBUK28sclcA2piA2sbcPd9gYvNXqXmpkBo9PdcyPFMbDoz0h6wktw
         z86cHXIxkkqFip472Kq9kIv3pj1Fi0ZwKEgZ9bTPy3/NXt0kxqxUCxZE7bLysigJGiMp
         eYNOSY7QkbQdFHjKjZ6wFc8vHHm8lhlmIBOtUBdehw5ozdbOUPjF1IK/ugI++jV6zuWU
         UfFwF0KQEXng31MASJnbe8RsftFr1GO42py26tB1xFc5SmNbgc4eYStOrDcSkh9QcpUl
         jMLg==
X-Received: by 10.60.45.102 with SMTP id l6mr26391786oem.36.1384298911413;
        Tue, 12 Nov 2013 15:28:31 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id eg8sm36329831obd.6.2013.11.12.15.28.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 15:28:30 -0800 (PST)
In-Reply-To: <xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237764>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Does it?
> >
> >  % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
> >  % git fetch origin master
> >  From /home/felipec/dev/git
> >   * branch            master     -> FETCH_HEAD
> >   * [new branch]      master     -> refs/remotes-test/origin/master
> >
> > In this case remote.origin.fetch is determining how to translate ref names, not
> > what gets transferred, *exactly* the same as we are doing with --refspec. And
> > as far as I know, remote.origin.fetch is a refspec.
> 
> If you had 'next' and 'pu' branches at the remote, do they get
> fetched with that command line?

No, why would they? You specified a single branch to fetch. Try it yourself.

 % git clone git://git.kernel.org/pub/scm/git/git.git
 % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
 % git fetch origin master

-- 
Felipe Contreras
