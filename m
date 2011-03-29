From: Tor Arntsen <tor@spacetec.no>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 08:15:58 +0200
Message-ID: <AANLkTi=5e4WUuZHcEJD50yJTw2eyYN_dN1S_7z62qy88@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:16:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SDn-00070M-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab1C2GQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 02:16:00 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38101 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab1C2GP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:15:59 -0400
Received: by qyg14 with SMTP id 14so2759192qyg.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AiXUPMjn8xAf9GNiRx+ymTPo1vHWxx2VNmmK8hOIKXQ=;
        b=JUSWHXBQRPOw9KEs3ZK2l0Sih5g+OPle4rxTAiZoGu/51KPBb+mMqbe6XHfd2dOWCt
         CYRUVNvM78b4EzvbCsgOymmrrKmNfEoL8X6DM6J+QnCuWPffmFBu3IQ7LexXcqN0Txr4
         65yAnqvHTcqwV+GKEFt7mhJ6ZMpXzl2x10v1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=r9BiqB7BpLBDPGmXyFMfa03MsGSA2eHQp7MnWIU+CzAEXNvC5ms0cjRhTNGDo1/YlI
         SOVJrCDWYVpOARhWuYsHPvo9nw+sjS7uD6qdzY16D0rhGACO7YM+1g0Kj2Jc7V7hX4fr
         8AI6rYdhF8EvHK/R435rpQVkVomBoX77xsH/A=
Received: by 10.229.22.138 with SMTP id n10mr4125688qcb.175.1301379358798;
 Mon, 28 Mar 2011 23:15:58 -0700 (PDT)
Received: by 10.229.25.15 with HTTP; Mon, 28 Mar 2011 23:15:58 -0700 (PDT)
In-Reply-To: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
X-Google-Sender-Auth: eQ04bSfIBOwg2HT-6ELC1rg_-RQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170226>

On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> wrote:
> All,
> =A0 I have only have two commits in repo,then I want to squash these
> two commit into one through git rebase -i .However it fails
>
> $ git rebase -i HEAD^1
> it only show up one commit so can't squash (can't squash without a
> previous commit)

To squash commits with rebase -i:
git log
(identify the commit you wish to squash to)
git rebase -i <the commit _before_ the one you want to squash to)

e.g.
git log
1
2
3
4
=2E.
you want to squash 2 into 3: Use git rebase -i 4
(4 is really a hash of course).

HEAD^some-value is OK sometimes but when I want to fix stuff down in
the commit chain somewhere I find it simpler to use the hashes - just
mark and paste.
Anyway the real point is that with rebase -i you must specify the last
commit _before_ the range you want to work with.

-Tor
