From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: [PATCH v2 0/4] merge: make merge state available to prepare-commit-msg hook
Date: Thu,  9 Jan 2014 00:45:40 +0000
Message-ID: <1389228344-38813-1-git-send-email-ryan@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ryan Biesemeyer <ryan@yaauie.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 01:46:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W13lU-0004iY-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405AbaAIAqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:46:24 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54929 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097AbaAIAqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 19:46:23 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so2277389pbb.17
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 16:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYdQ2egEX96sX3uCJ1WJQi6K57d6a4kRwsNzDuw/tfs=;
        b=HAT6jdwiUTuioCBnji8VKqgRfEG0HZyAs+9mTZGAiTNWwCK7ddeoa3U13UFyJuzes7
         bANuhy3/CgpdXcND6pMn7kaIjvXxL2T1wOh5GvxpQp0rfhJkvVi/OGUlJ8Gs+gVe0LKm
         GIHWtpHJfcuYceUwdZSzQ6ifdtbiQ9Cm1hybTRxGHF6hjFW9THCc35OaV+o50VgNQMmZ
         3EuXYeBEIpgWtZwlrcNHhErmCTWeFIyH+lFpMhTx7DJP+0ltpCcsgOkjui1s46gUCvxG
         BxA7BNCN0GgT3Zgj0lhhuz//V/Np7hdNFoPE6Rw/YzorTJDk1E/rjtvwwhHjZNsHGJVU
         0AOw==
X-Gm-Message-State: ALoCoQmwFMWviWUs3PYA9BVLMzdzxepNRmX/rnVd9k9munb4b9DjM2GEtDzH+J+n7to/HQIJ5b7S
X-Received: by 10.68.226.9 with SMTP id ro9mr248665pbc.72.1389228382948;
        Wed, 08 Jan 2014 16:46:22 -0800 (PST)
Received: from beorn.local.com ([69.164.175.238])
        by mx.google.com with ESMTPSA id xs1sm6854477pac.7.2014.01.08.16.46.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 16:46:20 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240234>

Ensure merge state is available to the prepare-commit-msg hook.

v2 patchset incorporates early feedback from the list

Matthieu Moy (1):
  t7505: add missing &&

Ryan Biesemeyer (3):
  t7505: ensure cleanup after hook blocks merge
  merge: make prepare_to_commit responsible for write_merge_state
  merge: drop unused arg from abort_commit method signature

 builtin/merge.c                    | 13 +++++++------
 t/t7505-prepare-commit-msg-hook.sh | 30 ++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
1.8.5
