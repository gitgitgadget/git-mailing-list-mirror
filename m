From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Subject: git imap-send: International folder names don't work
Date: Mon, 1 Jun 2015 12:31:20 +0200
Message-ID: <CAHpGcMJccbA3j-5MJ6Ux3J6M7p=dcAs4aKqzowSP_dMhf0Mevw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 12:31:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzN0B-0003CE-6I
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbbFAKbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 06:31:23 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36682 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbbFAKbU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 06:31:20 -0400
Received: by obbea2 with SMTP id ea2so99789525obb.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=67fKlMwmklFALA+VwE3S61zeLYWrJTEe6M+69tm5Hpk=;
        b=Z3wFZKzuYAqDv+ZmwWVKYMWgPPldrobJbGNz4zL1GrqrMYtlIQ0eW0RxwRr61WOOzr
         5N/oWjwSLWVHmanI5YGSPFV8vfu/i6lgea6ri6VnLeIviANPH6/6ssk5fyFnM1S//0Mw
         OY+AWRuI3rcsephSjWQwu5ewcbS4SNqzbze1fOo/jYQcYZMVLXvkd+tU+4hef3cn0s6S
         WYjZGMtx8dHI1JXDxcUjoLuJNV3OJ3UU4cFl/O4ta5653uVm5wFzxusrKEzLou/38GTF
         ExgRN8fDuD0Nf7UsERhn+Ok8eZAhxLZbs0VAHYwWqh38xORmxZ0y1KA3LkjYSnalAdzq
         3bEQ==
X-Received: by 10.60.101.195 with SMTP id fi3mr14246542oeb.65.1433154680243;
 Mon, 01 Jun 2015 03:31:20 -0700 (PDT)
Received: by 10.182.143.72 with HTTP; Mon, 1 Jun 2015 03:31:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270396>

Hello,

the imap.folder config option specifies the folder name to use on the
imap server.

At the protocol level, according to RFC 3501 Section "Mailbox
International Naming Convention", folder names use a modified UTF-7
encoding. The git-imap-send command doesn't encode the folder name
though; folder names that contain international characters don't work.

=46or example, my drafts folder is called "Entw=C3=BCrfe". When I set
imap.folder to "[Gmail]/Entw=C3=BCrfe" I get an imap server error. When=
 I
put the encoded folder name into the config file
("[Gmail]/Entw&APw-rfe"), messages go to my drafts folder.

Could this please be fixed?

Thanks,
Andreas
