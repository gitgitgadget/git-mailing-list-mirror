From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/3] fix push --progress over file://, git://, etc.
Date: Thu, 14 Oct 2010 03:31:48 +0800
Message-ID: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com> <20101012192117.GD16237@burratino> <20101012193204.GA8620@sigill.intra.peff.net> <20101012193830.GB8620@sigill.intra.peff.net> <7vzkuim1zx.fsf@alter.siamese.dyndns.org> <20101013174543.GA13752@sigill.intra.peff.net> <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com> <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Cc: "Jeff King" <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P673V-0006D5-2P
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab0JMTb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:31:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47692 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab0JMTby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:31:54 -0400
Received: by iwn9 with SMTP id 9so165884iwn.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RNvog06kpXW/XfHgw5BUfOiZv29SSLCWymaD1eWbkKA=;
        b=Kq4D2/otNb6e+uHqMoTrr/ut9biY5I9snEJlVtXGqdCj3ALvoXFOhUrqa8pj9qD0Wg
         Tbd8VcdqFNjFi86JPJ2MKFgTqwIoJ/Ix5JPDvfi2wtm+G0jy+rKuhcfFME3zIOgB/Dxw
         MbYlAps2jF8eytsFjfDKeSZk9YTnOu3FXHTRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jIlN2Luq/QyNtc8ghhAa679y5VO27Jjmd9I/sevsqe+s/P/i7g3VQZiO3AejZQLGrW
         wGY3VHthZnF/oOgcSaqkdOIFMts8oc5jmQxU18+OFmnBxVAoGFj8eD7/Iqs2y3AjLA5I
         MYa/drcMHD3unzpZsl80kmdr1vgAvlMuy7y5s=
Received: by 10.231.34.139 with SMTP id l11mr7414835ibd.141.1286998313593;
        Wed, 13 Oct 2010 12:31:53 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id 8sm3050710iba.16.2010.10.13.12.31.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 12:31:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158965>

*** BLURB HERE ***

Contents:
[PATCH 1/3] t5523-push-upstream: add function to ensure fresh upstream repo
[PATCH 2/3] t5523-push-upstream: test progress messages
[PATCH 3/3] push: pass --progress down to git-pack-objects

 builtin/send-pack.c      |    3 +++
 send-pack.h              |    1 +
 t/t5523-push-upstream.sh |   24 +++++++++++++++++++++++-
 transport.c              |    1 +
 4 files changed, 28 insertions(+), 1 deletions(-)

--
1.7.2.2.513.ge1ef3
