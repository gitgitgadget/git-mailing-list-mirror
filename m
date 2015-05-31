From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make them public
Date: Sun, 31 May 2015 10:54:36 -0700
Message-ID: <xmqqiob8aazn.fsf@gitster.dls.corp.google.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
	<CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7Rb-0004m3-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388AbbEaRyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:54:39 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33076 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758379AbbEaRyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:54:38 -0400
Received: by igbpi8 with SMTP id pi8so46464502igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mWLOXwf3MAiBUV1//yl2vkvmo6K/q1Wvh2xLsu7Z/Ac=;
        b=o05tzLE/pVGVTGrrsztpDuEq7JEyJEEhBw4KdYz7MjxkZqdCnjDphOEnUCuHcMSP2G
         dzvszOR9eqTrGN9Hx0/c56i8Qru27jhcSvvvnQ4Eg14r2nMUXOkpU7y8HkH1SjtTMck0
         w5VFYV0mLNT6Eie2ZOx5iGQf73P1R8X6ci2q+TnhFcrYU20TyS5jR+lxvh+xW6SCnPRM
         Utv0pXR6nsAPpzbMdxTNaRNEAejMLHcQGbrJcxCxAeLNhTbHr/SJCLeSdZ27M3JSvQQX
         6ZChNdMVjExGpqBQaWVSg1hTcwFT+PA4GRGQMipygrtwkZzaoVxCh1sgRz9Vu0vVDvsf
         1gvQ==
X-Received: by 10.50.79.167 with SMTP id k7mr8748028igx.32.1433094878208;
        Sun, 31 May 2015 10:54:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3d1d:5ddf:1454:826b])
        by mx.google.com with ESMTPSA id 137sm8738888ioo.29.2015.05.31.10.54.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 31 May 2015 10:54:37 -0700 (PDT)
In-Reply-To: <CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
	(Christian Couder's message of "Sun, 31 May 2015 10:04:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270339>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> -static void sort_refs(struct ref_sort *sort, struct ref_array *array)
>> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array)
>
> It is probably better to call the above function ref_array_sort()...

Care to explain the reasoning behind that suggestion?  The function
"sorts" "ref_array", so verb-object sounds like a valid construction
of a name.  All the functions externalized by the patch under
discussion follows that pattern, I think (e.g. parse-ref-filter-atom,
verify-ref-format, show-ref-array-item).

Making the API function share a common prefix is another valid
school of design; while that may justify ref-array-sort(), but if
you are going in that direction, all the others need to be renamed
along that line consistently, I would think.
