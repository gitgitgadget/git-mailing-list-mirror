From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Mon, 15 Apr 2013 09:46:40 +1000
Message-ID: <CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com> <CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 01:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URWdp-00021o-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 01:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab3DNXrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 19:47:12 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37030 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3DNXrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 19:47:11 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so3864513oag.8
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 16:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=OKHYox4DdOCty60+prBJWR6T3KaTYbqtbWShZ/9WqX8=;
        b=PRKDdCYDaAtH1ul5Cr1RqY1VgRcsa3a2m1XK8joJQ+QeX+LV9wr/9x1bzXl+FbHfpf
         7OfS9uSVqJVhNZDsH5Ee9LYsuQ+rI4EMoNl0mEqqCpjvxOSYX2jJF6E7O+dbkQC+CrZA
         pAadFSb2e4mc1WQrmZhPIl08vhYhHmCn1OdRTMb3lAUV5o9vtaNl5xOw488vUCKEultn
         wimoopm5nKwYsNVY7RVA2qahUmPq75SSAfCXQuRC13gQjVLup2VhIWNrv38PTEoHu2td
         TEq7JEaADjY0pnTeQVXFpMTQEI5pLmvyI2COH2+3QwUT8N07n8I0TgQR8Z2qk6rY31nB
         YFQg==
X-Received: by 10.60.34.98 with SMTP id y2mr6471892oei.74.1365983230899; Sun,
 14 Apr 2013 16:47:10 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sun, 14 Apr 2013 16:46:40 -0700 (PDT)
In-Reply-To: <CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221167>

On Mon, Apr 15, 2013 at 9:22 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> +       char fancy[80];
>>>
>>> -       if (show_upstream_ref)
>>> +       if (show_upstream_ref) {
>>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>>> +               if (want_color(branch_use_color))
>>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>>> +               else
>>> +                       strncpy(fancy, ref, sizeof(fancy));
>>> +       }
>>> +
>>
>> Please use strbuf for "fancy".
>
> Why? We would need to initialize and free it. What's the advantage?

>From a quick glance, I don't see any gurantee that "ref" (plus ansi
codes) will always fit in 80 bytes.
--
Duy
