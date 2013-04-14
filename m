From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Sun, 14 Apr 2013 18:22:16 -0500
Message-ID: <CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 01:22:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URWFl-0002I8-PA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 01:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab3DNXWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 19:22:19 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:43711 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3DNXWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 19:22:19 -0400
Received: by mail-la0-f45.google.com with SMTP id gw10so3915936lab.32
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=IPc7H7Pl81iZIZCCKwNuAlC6+iejlD5lXGJFRTt3QPE=;
        b=zHzXU+VFmfRH6Ktg7EeReC36lXKBtx2ongYbYyEo+FzTAZy2ZrslRtL7fVdGcUwb/T
         Dcrn0NKkYnhzgnBn9H3LUFBJ00mI3oas9n8k6tytjqjBvhrxrhhsCZfEMfA3NovxOE6/
         nHhrodeKbg7GPVPbyYAFpnJkS2YzSkaV6+/oY/qPnEASB1AEDLO20zKZfysrDpDcD2eZ
         2Mzp2TO1qjcnw+bsed/v/yQYgH5/cs6uKJW/GUxfbXKbOGpzHoP6FXVyyiV7GXCShXvE
         wgY32PlC/kFDjJvVst8W+h7c0q+xicmLA1GuTGvusaDPU0Cqgl0op7ItadBeyoy1aQuG
         uERA==
X-Received: by 10.112.20.106 with SMTP id m10mr9245081lbe.8.1365981736887;
 Sun, 14 Apr 2013 16:22:16 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 16:22:16 -0700 (PDT)
In-Reply-To: <CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221164>

On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> +       char fancy[80];
>>
>> -       if (show_upstream_ref)
>> +       if (show_upstream_ref) {
>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>> +               if (want_color(branch_use_color))
>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>> +               else
>> +                       strncpy(fancy, ref, sizeof(fancy));
>> +       }
>> +
>
> Please use strbuf for "fancy".

Why? We would need to initialize and free it. What's the advantage?

-- 
Felipe Contreras
