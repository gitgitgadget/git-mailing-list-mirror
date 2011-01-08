From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sat, 8 Jan 2011 09:17:57 +0700
Message-ID: <AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
 <alpine.LFD.2.00.1101061956470.22191@xanadu.home> <AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 03:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbOO4-0006Yf-7Z
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 03:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab1AHCSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 21:18:30 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46171 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab1AHCSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 21:18:30 -0500
Received: by wyb28 with SMTP id 28so17974643wyb.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EzFmMdx0sEZDmqio3AUbg+5vXFKV4LFC8GfBP2xO0R4=;
        b=wYK1CKaOa9K8DScVcNWUGnALl31CLtVA34oa7CHnSihNtYEIINjGTDwftX3s9kURuD
         uZUtYiH++JnKRFo/msGFj8Dw0iWrVqOBDTE9UzAndSNc2ZTVA2ViOzVo4WP571rWiOwW
         VpyFCjEb7BqbdFKhYmSHkbVyP8VFyIEB1fbfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=np57ENApnGgvs7o/IYc4tC6gb9OXXHFqsFP8IPrPi4lZShvO/Ja2TE70oEFXAdkG3C
         R9EeCJd/45gl4GrMSzDB2x49KQ3XqJzjl6JwK+V9tcoBzz5W+it8IDaveataOuu2k/1k
         oqie72zruFMHSOavxOGX/9F0Ct009OvrVbWiU=
Received: by 10.216.59.143 with SMTP id s15mr1772778wec.49.1294453108670; Fri,
 07 Jan 2011 18:18:28 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Fri, 7 Jan 2011 18:17:57 -0800 (PST)
In-Reply-To: <AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164801>

On Fri, Jan 7, 2011 at 10:59 PM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> =C2=A0bottom line: my take on this is (sorry to say, nguyen) that i d=
on't
> believe bittorrent "pieces" map well to the chains concept, unless th=
e
> chains are perfectly fixed identical sizes [which they could well be?
> am i mistaken about this?]

there are a few characteristics of bittorrent pieces that i see:
verifiable, resumable, uniquely identifiable across peers and
reasonbly small in count.

The fixed size helps peers uniquely identify any pieces by splitting
the whole transfer equally and indexing them in 1-dimension. It's a
rule to help identify pieces, not the only valid rule. In git, given a
commit SHA-1 we can identify any parts (or "pieces") that are
reachable from that commit using rev-list syntax. Therefore the
"identifiable" characteristics still holds even we don't split in
fixed size pieces.
--=20
Duy
