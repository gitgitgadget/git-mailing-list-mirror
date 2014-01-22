From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Anomalous AUTHOR and DOCUMENTATION sections in manpages
Date: Wed, 22 Jan 2014 11:49:46 -0800
Message-ID: <CAJo=hJuW3BdZUpvGL3fgry=w04YpwZTUZkMW6BeeTXfMbyKK6A@mail.gmail.com>
References: <52DFA9EF.4080309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 22 20:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W63oY-0004KY-65
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 20:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbaAVTuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 14:50:09 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:65074 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbaAVTuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 14:50:07 -0500
Received: by mail-wi0-f176.google.com with SMTP id hi8so6087145wib.9
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Uy2ng1lEYBLisECdo2VkDWwfelUF8qrpDh4EIDye2vk=;
        b=Er6oWci593qQxOrSWhIDIEjWDJENt613/qdYqcmD+P0V+WUMOREt2ga6qxLaowW+Wb
         qc02WbiGXt/u8V7NpAh0LW1ScqJlUlPdagxl8RBBCg03h3ctrFB5TvSS16yUeSR/3TlM
         ZFVw3MXwHqZ4nm/kVjZ+BcthQLEijxsqD0iMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Uy2ng1lEYBLisECdo2VkDWwfelUF8qrpDh4EIDye2vk=;
        b=m3OSr+1a2PNqwJy79TCq8k/mfT64LAuE7oxMtn13Gk6lo1Fsy/TIzh0JInd6scQNiy
         9+EmMPKGdaK+EypVL/4S7mlDHqdOxZ4X/x4O6j1ZgFjaasJMYwTU+m7LLqXUurj370kF
         ueZJqljF1YKU82vr4U8td+w8UZIFY2m6ZxYp299I510G5dxdyzkokefQXAyO356dMdbL
         /UijTRupsTh+EWb70A8X4gh88NBaoCJX5EwuDINlZ9YRq/w2AMJJ3M1N8EQ9NVccGqnx
         yWhaQVazKlSt1KjhUPXhu3G8O6VZxVVxWWNNXmHKWD8Gbf7hDCQEl1DojSURaaH5sul8
         MaaQ==
X-Gm-Message-State: ALoCoQmyVPMl9lYerTKlCHNM0i4Wp9m8bSt0XE5xClyttkvA3HxCM6lQNl+upzT3XeK8lUUSzKX8
X-Received: by 10.180.107.136 with SMTP id hc8mr21681574wib.11.1390420206118;
 Wed, 22 Jan 2014 11:50:06 -0800 (PST)
Received: by 10.227.16.136 with HTTP; Wed, 22 Jan 2014 11:49:46 -0800 (PST)
In-Reply-To: <52DFA9EF.4080309@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240845>

On Wed, Jan 22, 2014 at 3:22 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I just noticed that there are exactly four Git manpages with an "AUTHOR"
> section and five with a "DOCUMENTATION" section:
>
>     $ make doc
>     $ grep -nIE -e '^\.SH "DOCUMENTATION|AUTHOR"' Documentation/*.[0-9]
>     Documentation/git-column.1:80:.SH "AUTHOR"
>     Documentation/git-for-each-ref.1:272:.SH "AUTHOR"
>     Documentation/git-for-each-ref.1:275:.SH "DOCUMENTATION"
>     Documentation/git-http-backend.1:404:.SH "AUTHOR"
>     Documentation/git-http-backend.1:407:.SH "DOCUMENTATION"
>     Documentation/git-notes.1:395:.SH "AUTHOR"
>     Documentation/git-notes.1:398:.SH "DOCUMENTATION"
>     Documentation/git-remote-ext.1:133:.SH "DOCUMENTATION"
>     Documentation/git-remote-fd.1:71:.SH "DOCUMENTATION"
>
> These sections are inconsistent with the other manpages and seem
> superfluous in a project that has, on the one hand, a public history
> and, on the other hand, hundreds of contributors.  Would the mentioned
> authors (CCed) consent to the removal of these sections?

Fine by me, authorship is documented by history and blame anyway.  :-)
