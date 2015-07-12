From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Sun, 12 Jul 2015 15:59:45 +0700
Message-ID: <CACsJy8BL0ccxNYLE0gqBx5KTpqTOt=Ut6-k3fauxXNt2wpxSEw@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com> <CACsJy8BsLnkPFX04WujMdnBiRGmXacF1QSQudb3T8nxGrZ_1Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 11:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZED7Z-0004TE-R5
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 11:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbbGLJAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 05:00:16 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37657 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbGLJAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 05:00:15 -0400
Received: by igpy18 with SMTP id y18so39014967igp.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Karoo6eNFpZk2SfPc/gSsTUZ1agAaS/WxkSfWY4IgYE=;
        b=goK9q/QFWJamo2KYYcnaGgfCy4kn75hn6+zIwlIbpvT/EX5wd/9fHctNgMhqU77USf
         ARKjQdxWd3vUTGOegK5/JNcujA8z7YVdbq6ArHYeKc8ek2qSYx2D2WNN+iNu72TBvp/S
         NTPInBAZrtVw9unCyORZQpe28542h/NaN68deT17re3AnIopvK407TWMZi+dSYqDoA46
         aGWm8MUWDRFcyLYGqd7fMn5/6V59Ygv24o/MUD6HqUFc4ITo49k8DjtSrVQw+bqiFPik
         E0EXopx9KVFsPB4nOBGaaUJfW2EOVusykPnjsuAP+XqWM+Z1thAyAcSGJ+zllQgda9AB
         E5rQ==
X-Received: by 10.107.168.99 with SMTP id r96mr11820381ioe.141.1436691614421;
 Sun, 12 Jul 2015 02:00:14 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sun, 12 Jul 2015 01:59:45 -0700 (PDT)
In-Reply-To: <CACsJy8BsLnkPFX04WujMdnBiRGmXacF1QSQudb3T8nxGrZ_1Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273887>

On Sun, Jul 12, 2015 at 8:47 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Another thing, the atom value is also used for sorting. When used for
> sorting, I think these padding spaces should not be generated or it
> may confuse the sort algorithm. Left alignment may be ok, right or
> center alignment (in future?), not  so much.\

Correction: I'm wrong. This is only true if the atom for sorting is in
the same atom list for display. But we create new atoms for sorting in
parse_opt_ref_sorting(), where we drop everything after ':', so
"shortalign=" shouldn't be there when populate_atom() for sorting is
called.
-- 
Duy
