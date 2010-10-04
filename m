From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 19:17:41 +0000
Message-ID: <AANLkTikdiLRDBchYiZedATPS5ct0nSa6CahxuZiTk3x0@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
	<1286099806-25774-7-git-send-email-avarab@gmail.com>
	<201010041802.57398.robin.rosenberg@dewire.com>
	<201010042102.31336.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:17:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qXk-0005Lo-W2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409Ab0JDTRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:17:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57410 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab0JDTRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:17:42 -0400
Received: by iwn5 with SMTP id 5so7269180iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=csRVyhk34HdvCRpcWQkhZcY5DOTGEi2Wlo9HTcnAedI=;
        b=naOnqd09tvs+vCBUrDXoQQBoX0ytGI2Dtxz6KQhFuUNGIQ+ajoHHrwaVlJkDADt2RN
         PkraRmJHPw7r2IKm6mQuwbKeRUFZ8H6x3PKsVmlrGp6M0JsR+ffzKOj4djOZ0IDTN+2g
         uSjhZCT4hRRWUdVTZyhNr8+uRgomR0VlUOcCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QzXjuSqmkW2xefxmyqSA2xmqwZoP9Ra+nJiqGI91ObbjtAcllB7htKdI3bWsjhErsV
         2Y6HKnkiN20N5k76EZEUNPLT73+hfwv6PiQfxzbaGkimTZ0Pvly/9W2DVfndD9uGDzbJ
         22PJU4tFLgGg9XFO4XYBT1WnLldvpe2r5Speg=
Received: by 10.231.60.4 with SMTP id n4mr10721934ibh.18.1286219861655; Mon,
 04 Oct 2010 12:17:41 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 12:17:41 -0700 (PDT)
In-Reply-To: <201010042102.31336.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158100>

On Mon, Oct 4, 2010 at 19:02, Johannes Sixt <j6t@kdbg.org> wrote:
> On Montag, 4. Oktober 2010, Robin Rosenberg wrote:
>> Is anyone thinking "unicode" around here?
>
> My recommendation these days is that you should not use git if you care about
> Unicode filenames: git is tied to POSIX in this regard, which defines
> filenames as streams of *bytes*.

A SCM is all about giving meaning to streams of bytes. Just because
POSIX only says that filenames are \0-delimited blobs that doesn't
mean you can't have some annotation elsewhere that says "hey, these
blobs are in $encoding".

<insert another disclaimer here about implementing this being a huge
 task, but I'm just saying...>
