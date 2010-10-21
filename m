From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Thu, 21 Oct 2010 18:30:11 -0500
Message-ID: <20101021233011.GA13779@burratino>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
 <7vaam7rv49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	bebarino@gmail.com, avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 01:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P94e4-0004EQ-R2
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 01:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab0JUXeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 19:34:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44426 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab0JUXd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 19:33:59 -0400
Received: by ywk9 with SMTP id 9so184093ywk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MZfLEJKnevWNe8w2JhH03c55l0diJbjqANmCJ1lcLtE=;
        b=C0GRMO/eAk5aUG9N0Dqv8efEIBIqFhOhzgLiTM1WszXZOx9vUwLl9omfiIGQkHg10/
         Xld67EYvfXR4+BoCvnly/S3b51dT+BI8oUsIjh2rmcqOz8x+1eF5aFzojI2L9kpvFXOe
         llxPQ7/qvxzNVbbtUPxVlPdYX1hpgV5vLRuRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sTEg9NbLCw7IceVf+g1/TVHHFyr/nZLmjjP+RmBMDNlGLt8nM/UzGzAisD8LXC8F2+
         s+gAyUuYl89uhgHAyghSjGbsWO7B9SndwMqo+QRERgcOt4hnA+p/TGstZLLEdOT56uXa
         pN5r370uLeHxv1xyBN5TAduildqXXwYka1vSw=
Received: by 10.42.183.6 with SMTP id ce6mr1235626icb.313.1287704038642;
        Thu, 21 Oct 2010 16:33:58 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm1960516qck.37.2010.10.21.16.33.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 16:33:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaam7rv49.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159590>

Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:

>> Can someone comment on whether "git reset --merge" is a good
>> implementation of "git merge --abort"?
[...]
> I think it depends on in what state you started from and how the merge
> operation stopped.  If your index was clean, probably yes, but "git reset
> --merge" may not be something you may want to do if the merge stopped
> because you had previously added something.

I suppose it would be safe if one checks that MERGE_HEAD is present
first?

It would apply to failed cherry-picks, too.  Not sure if that's a
good or a bad thing.
