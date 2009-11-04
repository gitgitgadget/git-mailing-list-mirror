From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare 
	repos
Date: Wed, 4 Nov 2009 22:11:11 +0530
Message-ID: <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
	 <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 17:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ivB-0001gM-Th
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 17:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbZKDQlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 11:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757045AbZKDQlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 11:41:09 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:65195 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979AbZKDQlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 11:41:06 -0500
Received: by iwn10 with SMTP id 10so5061951iwn.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 08:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=27RxgWGh2VsTHu3M+Hi/qZZhrAtIVcVMGVJKeYodC74=;
        b=sQ7/9juZ82zU74mpMCoC/CeHaR3m22YuSLYBGnhEwQctN1Z8R0BE6Um2V5AIUC2kAb
         mlQkKqUc+5leg9VWoTSz6MVEsUtMvPejtejK2B1cmUMAaWkPJ5VXj+MpPgKTJ7RfStF7
         xkx+hhHGop/ru4w47navS2zGZYmmiaXgpyMtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KEKomIWhBKQ8YgJGJ9yLknRHxASEXGlzAM+jnpNTxqw9MFZjdKPMgbb3EXlmVDnSHf
         tP/P+eyQ34O8KSdDCY+kg3jbeUITAkHg4XtDjhWay9vwl9CIevoX16hDlkfvkl2nIxrw
         +4XLARzcGB7wsP+UIFm4k0qUQOfAAKJLrprh4=
Received: by 10.231.153.69 with SMTP id j5mr427839ibw.33.1257352871074; Wed, 
	04 Nov 2009 08:41:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132094>

Hi Johannes,

On Wed, Nov 4, 2009 at 6:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I did not have time yet to investigate, but it seems that there are
> problems with the permissions of shared bare repositories when activating
> the reflogs.

Interesting; I will try and investigate if I can find something.

> With gitweb on a public site, there might be a problem when you pushed
> some blob containing trade secrets accidentally, and try to scrub the
> repository using "git gc" after a forced push.

Agreed.  This config variable is biased to *keep* data if set to true,
and (default) false value is biased not to keep that same data, so
that will always be a conflict.

But if you are able to do "gc" manually on any repo you can also do
"reflog expire" before "gc" can you not?  Please correct me if I'm
wrong.

Regards,

Sitaram
