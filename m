From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v3] gitweb: fix wrong base URL when non-root 
	DirectoryIndex
Date: Sat, 14 Feb 2009 15:29:49 +0100
Message-ID: <cb7bb73a0902140629pa1ad038pe898aa0d804d0707@mail.gmail.com>
References: <200902122303.37499.jnareb@gmail.com>
	 <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
	 <200902140342.26270.jnareb@gmail.com>
	 <200902141104.35042.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 15:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYLY6-0000BU-Vg
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 15:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbZBNO3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 09:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZBNO3v
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 09:29:51 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:40031 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbZBNO3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 09:29:51 -0500
Received: by ewy14 with SMTP id 14so1342446ewy.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SIhRNEQwn57fXWvNT3CHxiXdx2HTLevcffI7QJ7B1MA=;
        b=tXU2hX2iZRUXNyDWHNHcA4QSjWatGEvq+Z5nLOa62BJc+0SLJIUMGmbENMzxx4uhN8
         wJtEE96zELjvUctoVpdEW3vUAzjcIwHU9Qo+TUncOLVj6DQ4uHN4p1zKwrqRVBNDav8r
         pxK/AgppB+J4VzEPdA6jqze1NjAcnbtVH3o18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lfwkSVPJ+KxNlxeN6S/ksB+gs9m2dXcKTHC2HZfKYPpq5v00w7ViGWXMMh2I7TzHDW
         c/gUjuUOAw8yjAV1YhDbyXszGAYv7aCE2jvnrBXVec/nLYvnDU2gjdzjOjZGx5PHz374
         0FghYpO3UrnTOv5HbIp0SbZv/vxjscySMGjcQ=
Received: by 10.210.30.1 with SMTP id d1mr899271ebd.73.1234621789157; Sat, 14 
	Feb 2009 06:29:49 -0800 (PST)
In-Reply-To: <200902141104.35042.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109871>

On Sat, Feb 14, 2009 at 11:04 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> P.S. I wonder why Giuseppe's patch failed to apply, and failed
> to do fallback 3-way merge...

Because it depends on an additional quoting fix that I sent to the
mailing list but that apparently didn't get through.

> -               print '<base href="'.esc_url($my_url).'" />\n';
> +               print '<base href="'.esc_url($base_url).'" />\n';

The quoting fix was here: double quotes are needed because otherwise
the \n gets in literally. We can probably squash it with this patch.
Gimme a sec and I'll cook it up again.

-- 
Giuseppe "Oblomov" Bilotta
