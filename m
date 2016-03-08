From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 06/15] ref-filter: make %(upstream:track) prints "[gone]"
 for invalid upstreams
Date: Tue, 8 Mar 2016 11:40:04 +0530
Message-ID: <CAOLa=ZRSuX1+-yR2hte7=jhCnOXS057NMTo8P519JrBHMJkgQA@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-7-git-send-email-Karthik.188@gmail.com> <CA+P7+xpdW46_pS9=NuWOuuQd4LwE4_foiRirPNoyrubCYeBNcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 07:16:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adAwb-0004QU-U4
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 07:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbcCHGQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 01:16:30 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35346 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbcCHGQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 01:16:29 -0500
Received: by mail-vk0-f67.google.com with SMTP id e185so494930vkb.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 22:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g3B1HrwOR+tXiokyxGbsVNgwL2lIfCneBwLY0JRGR3M=;
        b=Up55Mz+YEM0jkg6bVHXt5MZ/r7krOoej3k/WCit/8NaFPfLOPnmoeIyxRsPA/Sra2A
         3mpuqR75FUwSgutaCmAaJPi0wXU7b9a5JV2eAzgUakUW/RAJAFEpeJO4OaXLwRD1IAxC
         w3BEmlgIW6Jcfg6W/wTgnIwrk8Nig1xf/811PJT2/wiOolFu/VJdOZSrA1wTN23QajDA
         a74332NnJ1n+W0Yw+p2lmuxDQ4JCgtYoWOcaOsDp++QuGJB1G2EzYOLUvDwGV7hTzdnJ
         LGP4RFkAW88IRU1OaU2hAmUkNeKEOt7HVJArd7J9uQ9P8ocgl1DcDhi1F8V76kN77OEi
         tdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g3B1HrwOR+tXiokyxGbsVNgwL2lIfCneBwLY0JRGR3M=;
        b=XKIWNlNP7BglLYBwNMsRBOMZIHtUWfPySpTh4uteQIamor/mi332dXzRIepYtrN9aa
         zZGltdQafsNq5XJ+LdY2+laiVPaTwdBPXchTcvr2VnviTjvI3GDtHfQArN87Q64P0oAJ
         sdkn6FbyaGAve9fQzfy2Foj2QgDsKp8B8pVuBwhkev4m4s46QBSzIL6qpFDCZHYeTFQw
         K1B+LtnEGOV2kuYQSvweH331Jk/t/417z/mhDepLd3fKsiSNlWQ7hqO+YdhM1SMZ9F5k
         hEcVzTebPxeEpczXXBNcgCQ4EteoF5Dh5leEDIOhUMmqorYX4ETVCt14dMvprjPKuDF9
         IKiw==
X-Gm-Message-State: AD7BkJJKjjCGe5zGYglWRGf594mrfleoxKQ+nqkOhjQe+awkc6HQDxK6rZmdrZulkYeoiEg2pJ/uZjrbds1XdA==
X-Received: by 10.31.54.75 with SMTP id d72mr23708363vka.30.1457417433634;
 Mon, 07 Mar 2016 22:10:33 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 7 Mar 2016 22:10:04 -0800 (PST)
In-Reply-To: <CA+P7+xpdW46_pS9=NuWOuuQd4LwE4_foiRirPNoyrubCYeBNcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288421>

On Tue, Mar 8, 2016 at 7:25 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Mar 6, 2016 at 4:04 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Borrowing from branch.c's implementation print "[gone]" whenever an
>> unknown upstream ref is encountered instead of just ignoring it.
>>
>> This makes sure that when branch.c is ported over to using ref-filter
>> APIs for printing, this feature is not lost.
>>
>> Make changes to t/t6300-for-each-ref.sh to reflect this change.
>>
>
> Shouldn't this be documented as well?
>
> Thanks,
> Jake

Definitely! will add that in. Thanks.

-- 
Regards,
Karthik Nayak
