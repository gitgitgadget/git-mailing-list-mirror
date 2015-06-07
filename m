From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv1 0/3] git-p4: fixing --changes-block-size support
Date: Sun, 7 Jun 2015 12:01:09 -0400
Message-ID: <CALM2Sna_sdD_95MO3EbF0+QSpB9W1K8Rv3-TNOmnovWG57gh7g@mail.gmail.com>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:06:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1d5s-0008AV-Fn
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 18:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbbFGQBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 12:01:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35909 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbFGQBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 12:01:10 -0400
Received: by pabqy3 with SMTP id qy3so78974730pab.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YA8Mr+NRjcGU9wHJAUWbA/5GMXmPLGZ95rz1PJZZdCo=;
        b=JBILiZgqtZGw5rwmcvLMhBoaDgpqr0kYAm74jtLNotmm+igMY66ojNtM0O7HTby0KC
         ve9s5dGz2TQv71gYu/m11VUKBLv098bp5Ii6Y6nNWoDMzoS4GWNT0P76N7yM5nVmtce3
         TMvwyLXB7Oyrb43Y14pkA0XQSMOBfN+WYrI/pm7c7ZU7WT1F5YCWJRBg7fZ6/6c5afmc
         gz2JAuhdTeU4vkkW3gzxicmO3xVQIF3jPYkvG063dPYrr0ei95KQzt9Mlo9vrJDZBpED
         GHAr7nG3Iw3AKFvtxBEkGmuWWaTOizbe1Km2mpzJZUkunJTlu8GPiT50dqbhVicKCGTy
         nh8w==
X-Received: by 10.68.209.227 with SMTP id mp3mr22292192pbc.100.1433692869886;
 Sun, 07 Jun 2015 09:01:09 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Sun, 7 Jun 2015 09:01:09 -0700 (PDT)
In-Reply-To: <1433672505-11940-1-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: hguge-YDTS3kyrq_LnrQ81D-P8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270972>

Great work.

For curiosity's sake, the -m solution has been observed to work on at
least one Perforce installation. However clearly it doesn't work on
others, so the batch ranges approach looks like it will be better.

Based on what has been seen so far, the Perforce maxscanrows setting
must be applying the low-level database queries that Perforce uses
internally in its implementation. That makes the precise effect on
external queries rather hard to predict. It likely also depends on the
version of Perforce.

Lex Spoon
