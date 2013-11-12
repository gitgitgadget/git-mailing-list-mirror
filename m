From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Tue, 12 Nov 2013 09:08:31 +0530
Message-ID: <CALkWK0mz9PFce4F6xiDBeT+Cf=7Mihbb0fp9fa9WJJaMr5uH-g@mail.gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
 <1383212774-5232-2-git-send-email-artagnon@gmail.com> <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
 <CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
 <xmqqli182mde.fsf@gitster.dls.corp.google.com> <CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
 <xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com> <CALkWK0k0wxoK-MZk-KXiUiUgxVBKQGROFJBZbRs2LjNLA9iopA@mail.gmail.com>
 <xmqqvc045bvq.fsf@gitster.dls.corp.google.com> <CALkWK0=w1G2O_W1LnfstqzaMjOQ0GWqJXeeRN4ymfsvohQBfyA@mail.gmail.com>
 <xmqqppqaol6w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 04:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg4p7-0005uk-J7
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 04:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab3KLDjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 22:39:23 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37295 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3KLDjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 22:39:12 -0500
Received: by mail-ie0-f174.google.com with SMTP id ar20so1928058iec.33
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 19:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wSjuLINtvMc5wypp0udCvPiYgg9IoBCXWiRJLfhYQOM=;
        b=vzsDCiqSinuQbEDvnO9bS1+/pAxHFm7ynt751aJPJHjcpjqE6vyt239TcditiQ2fav
         chEOAXmWsA7EXxeFXI88XzyNBpvONf1C1mxAzggpbY8yKuTOw0ynVL9RL2Hhr3X+U7CG
         zsLkkNhBO/+ZBccyKkqHSysXszzb8SQTT3S7l0LZ17q29FvRlh4j7D4x4n5DsH70DilI
         S1Xrgy1L3EdXZCwLSHoM+2pkvOZ+Ytquaj2bGihvPd7vFs7IFtdB8cCOOO7dzhJqkWrv
         ISvgngcI/J7QC31wihUvBFo33lea2tixcpKOz26xdey0r1qEqePT/NX02vmRfmMWu3TT
         jx5A==
X-Received: by 10.50.11.67 with SMTP id o3mr14354700igb.55.1384227552104; Mon,
 11 Nov 2013 19:39:12 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Mon, 11 Nov 2013 19:38:31 -0800 (PST)
In-Reply-To: <xmqqppqaol6w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237683>

Junio C Hamano <gitster@pobox.com> wrote:
>     $ git show -s --format='%CredAnd%CyellowAreNotTheSameColor'

Ouch, this is quite a disaster.

> It would have been much saner if we started from %(color:yellow),
> %(subject), etc., i.e. have a single long-hand magic introducer
> %(...), and added a set of often-used short-hands like %s.
>
> I am not opposed to unify the internal implementations and the
> external interfaces of pretty, for-each-ref and friends, but
> modelling the external UI after the "mnemonic only with ad hoc
> additions" mess the pretty-format uses is a huge mistake.

Okay, I'm convinced; I'll rework the series to do %(color:...) and
resubmit shortly.

Thanks.
