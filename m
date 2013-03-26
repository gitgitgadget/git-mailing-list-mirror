From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: [PATCH v2] difftool: don't overwrite modified files
Date: Tue, 26 Mar 2013 16:52:02 -0400
Message-ID: <CAJELnLFxEa6v39ocVD+VLj9b86HhURsnFa+UKc+r3xYPLStSNw@mail.gmail.com>
References: <cover.1363980749.git.john@keeping.me.uk>
	<cover.1364045138.git.john@keeping.me.uk>
	<e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
	<7vd2up4bo7.fsf@alter.siamese.dyndns.org>
	<20130324123620.GA2286@serenity.lan>
	<CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
	<20130324151557.GB2286@serenity.lan>
	<514FFFC7.3090004@viscovery.net>
	<20130325104219.GD2286@serenity.lan>
	<20130325214430.GG2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKarC-0007vs-H5
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab3CZUwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:52:05 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52724 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab3CZUwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:52:03 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so107773pdj.27
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=b5+JETbZ8Kh3rpwIv2yss1E5YW5kw3wypfjmlMgVFQc=;
        b=e6o8zHVIbwCTsaLNqv0e0HI8UFRqnq78YA5sv8KGnsbsSMt+pfFplS+GzUPj9o3tau
         DCjlvifc1XFBECfMzWOk0+LHo8L+qGptclQon114ULCu1Of+AA1kmq/5PueGhNqGMbPv
         fccCy+0ywGieTQGQomd0KJ0PuZM6/j/Lsybmq+PRFgiazAtfgWDz22fsg3vT1x0NC9w0
         FB8eDEKAAfb29LLLmqI9aCi/V5AP07mnUmMsFm4a+FGdcKPbWoJiMQs5XdOIZHEX3wK/
         hJbYTHRuubT6psq/7yub0rPvBJyrnf4HLdx0bkqNrtIrHRJTY1NxvcEzOI4WMvcNGGN1
         n5ig==
X-Received: by 10.66.163.69 with SMTP id yg5mr25829788pab.109.1364331122814;
 Tue, 26 Mar 2013 13:52:02 -0700 (PDT)
Received: by 10.68.0.66 with HTTP; Tue, 26 Mar 2013 13:52:02 -0700 (PDT)
In-Reply-To: <20130325214430.GG2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219206>

On Mon, Mar 25, 2013 at 5:44 PM, John Keeping <john@keeping.me.uk> wrote:
> Instead of copying unconditionally when the files differ, create and
> index from the working tree files and only copy the temporary file back
> if it was modified and the working tree file was not.  If both files
> have been modified, print a warning and exit with an error.

When there's a conflict, does difftool save both conflicting files? Or
only the working tree copy? I think it should preserve both copies on
disk.

-- 
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
