From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: pull.prompt or other way to slow/disable 'git pull' (was: Pull is
 Evil)
Date: Fri, 02 May 2014 17:20:11 -0500
Message-ID: <53641a1be8d24_1c7bdcd2f049@nysa.notmuch>
References: <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
 <53640bc1ee6eb_135215292ec95@nysa.notmuch>
 <20140502220107.GO28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:30:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLyq-00070Q-Ut
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbaEBWaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:30:52 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:50751 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaEBWaw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:30:52 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so5102886oah.7
        for <git@vger.kernel.org>; Fri, 02 May 2014 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ub6blvR7KjblUn1gjIbaVsoFWXdFaXRnu4bw/5HkYSE=;
        b=z+rRXhd1MoLzjvqIlYLjKvYdS+WHjvgzs9odXTR89975TZeTajalHRrw36CRmZsrEF
         IDCFEAMBJ8Q9OXgTfU1n/eqF2GeiQtNwnRLDL+va9fRckiiWINsBwrImpC8tst77y/mT
         lLYY8NJvWh6HOlqe4/IPuUJdJFFkxC7i1Sc01eTtkBKCcVQ+oqaLsCPZi0ob0s8MiyuU
         CH+IW4xpshODVkPLw5NMH87JgOrluV/l66zY6HWriyjG+5mjGQhByiCzZ+1GWG7CgkXq
         7svQJWJhS8n25tljSSX+yP+e+CrF0dUg1zY6FaVCSkUShng6GkU+I7NbPkIVcRDzW8Jf
         AbKQ==
X-Received: by 10.182.33.131 with SMTP id r3mr18048501obi.40.1399069851930;
        Fri, 02 May 2014 15:30:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ml9sm1394443oeb.2.2014.05.02.15.30.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 15:30:50 -0700 (PDT)
In-Reply-To: <20140502220107.GO28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247998>

W. Trevor King wrote:
> I've renamed this sub-thread (which started around $gmane/247835) to
> avoid potential confusion/dilution.

Thanks.

> > > The goal is to train them to do:
> > > 
> > > >   % git config --global pull.mode none
> > > >   % git fetch
> > > >   % git merge --no-ff
> 
> Sticking to my 'no-ff' topic branch example, this should have been:
> 
>   git merge --no-ff remote branch
> 
> I want folks to use --ff-only when pulling their default upstream.

That's proposed to be the default anyway, so they won't need it.

> > > The 'git pull' (with 'none' mode) explainer just helps retrain folks
> > > that are already using the current 'git pull' incorrectly.
> > 
> > If you are going to train them to use a configuration, it should be:
> > 
> > % git config --global pull.ff false
> 
> I don't want all pulls to be --no-ff, only pulls from topic branches.

Pulling some branch to a topic branch, or pulling a topic branch to
another branch?

Either way, since I think these two are different modes:

  1) git pull
  2) git pull origin topic

Maybe it would actually make sense to have a configuration specific to
2): pull.topicmode.

This way they could do "pull.topicmode = merge-no-ff". Or maybe we need
arguments: "pull.topicargs = --merge --no-ff".

-- 
Felipe Contreras
