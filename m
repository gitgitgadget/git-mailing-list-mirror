From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git-apply doesn't handle same name patches well
Date: Mon, 16 Jun 2008 10:01:41 +0100
Message-ID: <e2b179460806160201j133dac0eg37c88b5670541ff8@mail.gmail.com>
References: <1213376131-20967-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Don Zickus" <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 11:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Abz-0001Hj-MZ
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 11:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbYFPJBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 05:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbYFPJBo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 05:01:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:59117 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbYFPJBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 05:01:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3464693rvb.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XRfB00pAcfCkLYVBxekKZPs8wXPZtZl/TV435o9M2MU=;
        b=TWpiLQFsetT4nHNiPioPQTdaTx4NCcqNkMyVO6L2UQahrQGge3Ejoh1cT7mVraVmTL
         5e88aoz5jnJwyjsRJdUg6NvFyBibkv+5rhNuy8bNxNI3owpEjFjlOcXkqnLN4AH/1+fp
         ZVACffQPO24ekBtAHPN9RvgbmHsDDnn4KE7do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZIiJg7DIzxtr61dW2hGgCsfCSH58aMYx8JxWKQyIw4ObWz0KVwAxuCec+qiJIW2LLH
         KZ9Vb5/ttzcy/KqLhgVdS6YjQq05+yZPC5QirQqF3JMyQN7wdJ4X5y3MOW0qS83v+rE5
         ilXVw+6Qdvj088MCIeB5hFakNLS9z8bD0YRh8=
Received: by 10.141.162.16 with SMTP id p16mr3466193rvo.243.1213606901156;
        Mon, 16 Jun 2008 02:01:41 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Mon, 16 Jun 2008 02:01:41 -0700 (PDT)
In-Reply-To: <1213376131-20967-1-git-send-email-dzickus@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85168>

2008/6/13 Don Zickus <dzickus@redhat.com>:
> When working with a lot of people who backport patches all day long, every
> once in a while I get a patch that modifies the same file more than once
> inside the same patch...
>
> I have modified git-apply to cache the filenames of files it modifies such
> that if a later patch chunk modifies a file in the cache it will buffer the
> previously changed file instead of reading the original file from disk.

Excellent spot. A couple of things you might want to add to your new
test cases would be examples where the first patch renames or removes
a file (or two files are swapped) and a subsequent patch then touches
the same path(s).

Mike
