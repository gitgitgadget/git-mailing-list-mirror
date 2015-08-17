From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 03/13] ref-filter: introduce ref_formatting_state
Date: Mon, 17 Aug 2015 01:15:20 -0400
Message-ID: <CAPig+cSwZaNbUDG+46LfAGB4GjDm5sbkroO_mR+hvCcVHq00cg@mail.gmail.com>
References: <1439661643-16094-4-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRmFCpbJVzrAYqPRcJVKD7czfi7Mni_BzaoB2RkJnFJMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRClj-0005cB-GK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 07:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbbHQFP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 01:15:27 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36809 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbHQFPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 01:15:21 -0400
Received: by ykfw73 with SMTP id w73so63116557ykf.3
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VNxA22Ukdi5/NWFoTV7YurcUBepDcyE3VThxI7jHOX8=;
        b=PbuFRWTruN26ZnwsiLh1oKF/PKOAn8rPkTlMp+B5tl/YNxuxQheOm11R5MScfZ9Jde
         6dagG4t4cciRrsbdhM0MAD5+qwB1tH/k6L1QdFt21IiICSBXVRli+65OlpROPgjg+sQZ
         XmDCUOikT1dthwmMI6lURtHETyUAolo/ByJqRdZY9iDR1bTjSdqAcbMRTSVHzTz/r7gU
         v0GWP3u1rtpiUxEf38ffmEDalFeJiys9ND6p/3X0zmQYhGodiSOG0hHtOA+KCWzEDHFF
         vtn0BAi7pF3e5o80gvEhD87ZEXYFeuRANtfp6dcBOWyWvk4b6RadH31zO1v5Ij5mmG8o
         Wgog==
X-Received: by 10.170.172.84 with SMTP id o81mr28363805ykd.69.1439788520678;
 Sun, 16 Aug 2015 22:15:20 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 22:15:20 -0700 (PDT)
In-Reply-To: <CAPig+cRmFCpbJVzrAYqPRcJVKD7czfi7Mni_BzaoB2RkJnFJMg@mail.gmail.com>
X-Google-Sender-Auth: lkvH4_7q6CizVLQR6ID901Pjj8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276033>

On Sun, Aug 16, 2015 at 7:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> +struct ref_formatting_state {
>> +       struct strbuf output;
>> +       struct ref_formatting_state *prev;
>
> Upon initial read-through of this patch, I found the name 'prev'
> confusing since it seems you sometimes treat this as a linked-list
> and, for a linked-list, this member is customarily named 'next'.
> However, you also sometimes treat it as a stack, in which case 'prev'
> makes a certain amount of sense semantically, although so does 'next'.
> I'd probably have named it 'next', however, attr.c:struct attr_stack
> names its member 'prev', so there is some precedence for the current
> choice.

s/precedence/precedent/
