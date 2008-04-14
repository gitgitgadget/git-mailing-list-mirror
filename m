From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH/RFC 06/10] Unify the lenght of $SHORT* and the commits in the TODO list
Date: Sun, 13 Apr 2008 18:06:03 -0700
Message-ID: <905315640804131806j18d5c223w611725a66b0c420c@mail.gmail.com>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
	 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
	 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
	 <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
	 <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
	 <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de>
	 <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de>
	 <7vej9cndqp.fsf@gitster.siamese.dyndns.org>
	 <20080412091345.GA31356@alea.gnuu.de>
	 <7v63umff7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?J=F6rg_Sommer?=" <joerg@alea.gnuu.de>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 03:06:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlD9q-0006mb-1e
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 03:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbYDNBGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 21:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbYDNBGH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 21:06:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:50264 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbYDNBGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 21:06:05 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1359664fgb.17
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=eNR7db96tK9S5jo1+TYcbbYvHmwxgO5gjJcRJhRbNAU=;
        b=p5ZENxZW3lR5lQORRXE0qjoxDKVijsC75WONt854w8DCnl+lk04PhvcRCk4ZEfzPIo3bApbFNO+RwLXLK0lFp/+Ort+wC9OL0vTfImQ0mjbzQ9i5zFfBTEeOgM32OS9C+BkpOo+lgWUkppVGtaelfPvbPDDaSD2OlHjHBICsCl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lRgHGIeyDGn6Ap4mvyhY/c2f4B2CItmAqT3ffkMCBui1tQemkFinifcVF1FJvpqBa8FentGnrQNVXbJ+2Cc/9JeXuMIsWQSaBC64dmdKhG9R9qZmbBzB6iXxGWgvzZJPCVFd/wP9ahzluQLgR3I265a9iBFtXoWXoVC0wSjfTGA=
Received: by 10.82.182.1 with SMTP id e1mr8135657buf.21.1208135163779;
        Sun, 13 Apr 2008 18:06:03 -0700 (PDT)
Received: by 10.82.175.8 with HTTP; Sun, 13 Apr 2008 18:06:03 -0700 (PDT)
In-Reply-To: <7v63umff7r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 32f9fc3af2b18206
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79447>

On Sat, Apr 12, 2008 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  "Equality testing?" --- that makes me worried.  short=7 does not chomp
>  them at 7 but only tells rev-parse to use at least 7.  You may get 8 or
>  more if there are other objects that share the same prefix when you get
>  them.
>
>  Perhaps by forcing "at least 7" everywhere you are getting consistent
>  result that makes them easier to compare.
>
>  But considering that this is a candidate for a general mechanism to
>  eventual grow into the git-sequencer, and that we expect to have richer,
>  smarter, and/or more complex set of tools that feeds you the TODO list,
>  I'd feel safer if the internal comparison used to determine which one
>  commit the user meant in his TODO file is robust and does not rely on
>  where the abbreviated object name was chomped at.

Slightly offtopic, but has there ever been any discussion about the
scenario that the during a rebase operation, a new object might be
created that has the same first 7 abbreviation as another "pick" that
comes later?  It's unlikely, but it might get more likely as rebasing
grows in complexity and number of new objects created.

Thanks,
Tarmigan
