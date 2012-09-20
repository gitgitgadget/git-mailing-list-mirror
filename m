From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] New pretty format color specifiers %C+ and %C-
Date: Thu, 20 Sep 2012 19:26:14 +0700
Message-ID: <1348143976-4506-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 14:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEfpm-0006Qr-RC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 14:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab2ITM0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 08:26:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53547 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2ITM0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 08:26:13 -0400
Received: by pbbrr4 with SMTP id rr4so96433pbb.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BFFfRWirQhUOcoNXZP58/UlgC4I9z8OYyvs5VxtOc5g=;
        b=msZW7dAUMqCpGMtuRiQKVXO+1AXnS+O25blKd7x43zDhbrhANkz+id2OgEAltfNm5u
         Rv+pgrm89GlGK9RphKM0liKOWI9uV2T03iQ0kFPuCD9EQp7gtZPNLDnjdtgw/ho4MTxw
         FfXL3hGUONesS+LUuSGAfLBN0PWY0YulzTtWWrPAQFfNyMV5/ygElIeJMh8Se69hm8Ns
         mdUj42Z5XLH1UmFLowY1ghIVPegL9YlYbLHOe53BrFzyIHTm4zS0uE88M9em6FmkQbil
         COM/CZnyeAmaVzohVemWGvqASIdRmZQvO9g9hTMbWEXB3yD7HIteCOBc5Dh+2fdmwnAS
         8n4w==
Received: by 10.68.235.106 with SMTP id ul10mr6414928pbc.83.1348143972331;
        Thu, 20 Sep 2012 05:26:12 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id nt9sm3444609pbb.56.2012.09.20.05.26.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2012 05:26:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Sep 2012 19:26:20 +0700
X-Mailer: git-send-email 1.7.12.1.383.gda6001e.dirty
In-Reply-To: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206046>

On Thu, Sep 20, 2012 at 5:43 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> I tried --pretty=3Dformat:"%h %s %d" but the colors were lost.
> --decorate uses more than one color so %C* does not immitate the
> colorful output we have with --decorate. Maybe I should add %Cd as
> "colored %d" and update my alias to use it.

Here goes. I'm now a happy user with --pretty=3D'format:%C+%h %s %d'.
Somebody might want to add coloring to sig placeholder too.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  pretty: share code between format_decoration and show_decorations
  pretty: support placeholders %C+ and %C-

 Documentation/pretty-formats.txt |  2 ++
 log-tree.c                       | 55 ++++++++++++++++++++++++--------=
--------
 log-tree.h                       |  3 +++
 pretty.c                         | 30 +++++++++-------------
 4 files changed, 50 insertions(+), 40 deletions(-)

--=20
1.7.12.1.383.gda6001e.dirty
