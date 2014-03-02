From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] rebase's convenient options
Date: Sun,  2 Mar 2014 09:53:11 +0700
Message-ID: <1393728794-29566-1-git-send-email-pclouds@gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwXL-0000Mv-R6
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbaCBCx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 21:53:28 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34965 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbaCBCx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:53:27 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so2392166pab.18
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qN2msEr8YKM3sA0mKaAFhQPyHM2rx/olbEFjew0/8f8=;
        b=KZF+STKM75Dcne1ksS3hO1mJ5GJ4BvYlTh4Ud+VkJ7pU11dw/xuruhfz9vz2uC9Rle
         Vll4Imq4Y5mafnwlMv1vZyCUgrWLxOuNw35DItLZNC3jy1EKoJCwbcBny514+4SjT9Sy
         cFD6c4ue6cqZkfXK11HFefnL9O5d/TyeEnYtRtG8njk3WZDB/iM0lJll+9cm87M752qr
         hwkciI3Osg5Y6iLapf+qGrIRyXnKf/4+eT9PmW+Dc1qXmfmWEZ+yFkAL1iOMDplM4AXy
         ISXwSAyxW22xzStaRFAJyFHi3b1ouft5rqeI41whOst6+Zb0T7l7FLZq3aM77THhTjkm
         ifwg==
X-Received: by 10.66.142.107 with SMTP id rv11mr12159318pab.17.1393728806585;
        Sat, 01 Mar 2014 18:53:26 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id js7sm20998338pbc.35.2014.03.01.18.53.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 18:53:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 02 Mar 2014 09:53:52 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243121>

A polished version from the RFC. Now you can do

git rebase -i -10 -> git rebase -i HEAD~10
git rebase -e XYZ -> send you to commit XYZ for editing

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  rev-parse: support OPT_NUMBER_CALLBACK in --parseopt
  rebase: accept -<number> as another way of saying HEAD~<number>
  rebase: new convenient option to edit a single commit

 Documentation/git-rebase.txt |  7 +++++++
 builtin/rev-parse.c          |  9 +++++++--
 git-rebase--interactive.sh   | 17 ++++++++++++++---
 git-rebase.sh                | 19 +++++++++++++++++++
 t/t3400-rebase.sh            |  6 ++++++
 5 files changed, 53 insertions(+), 5 deletions(-)

--=20
1.9.0.40.gaa8c3ea
