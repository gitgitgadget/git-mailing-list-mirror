From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Mon, 15 Apr 2013 11:31:01 +1000
Message-ID: <CACsJy8Cecymz-vPQ_WwGzB8kR6B_j5vm8MPVykrO44C5Vk=1Zg@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
 <CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
 <CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com>
 <CAMP44s38e4n_jKC-f973JJUXuxkD2dqP+ECwzxvUMWxit2P2PA@mail.gmail.com>
 <CACsJy8CTmh2eMDqBpr0agiTGcHkP_AQBLLg2A4HM203u9G1v9g@mail.gmail.com> <CAMP44s27Tj4x5U34ysdfQx8uzxAz=yJZ+rkWxLWtQHzAeoF8SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYGf-0005hI-B4
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab3DOBbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:31:33 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:40542 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab3DOBbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:31:32 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so4031322oag.29
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nuKErzsevc4Pd6hShQiy4oZNsiYqDnRPpBo75uiYoGM=;
        b=XmlA9ZMnHh767wmQg5kiiG5sYSAnDTZQhWoigtUPnavH+LhZQLeh7ikAqrTP0Ot/fL
         cdTi+OcVHUrppexdiwhHlv0jMNX4RLaM+PIwQnmw++uO7HfwQhk+K1+coI/l1wvqHcsE
         j3YF8hvuerE94rbtlvip4zLN9w4XDiPpMiGs019goSy8G1z7yQNw43zGnjBwXqALzMY4
         rJKtEreyoSThY79QUY9DFpo5yaCseAJZ6lZ+6Rx2XgVcgvOOZCNtHvciMDxc5IsJ5CdN
         ooiPty+QJYiMHphxnobSt7pPLXLh415NZiz7dhKlqA3uXae4B0qq17XiUxnQntNX2EW3
         QM6A==
X-Received: by 10.60.135.103 with SMTP id pr7mr6678581oeb.142.1365989491918;
 Sun, 14 Apr 2013 18:31:31 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sun, 14 Apr 2013 18:31:01 -0700 (PDT)
In-Reply-To: <CAMP44s27Tj4x5U34ysdfQx8uzxAz=yJZ+rkWxLWtQHzAeoF8SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221176>

On Mon, Apr 15, 2013 at 11:24 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Apr 14, 2013 at 7:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Apr 15, 2013 at 9:54 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Sun, Apr 14, 2013 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Mon, Apr 15, 2013 at 9:22 AM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>>>> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
>>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>>> +       char fancy[80];
>>>>>>>
>>>>>>> -       if (show_upstream_ref)
>>>>>>> +       if (show_upstream_ref) {
>>>>>>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>>>>>>> +               if (want_color(branch_use_color))
>>>>>>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>>>>>>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>>>>>>> +               else
>>>>>>> +                       strncpy(fancy, ref, sizeof(fancy));
>>>>>>> +       }
>>>>>>> +
>>>>>>
>>>>>> Please use strbuf for "fancy".
>>>>>
>>>>> Why? We would need to initialize and free it. What's the advantage?
>>>>
>>>> From a quick glance, I don't see any gurantee that "ref" (plus ansi
>>>> codes) will always fit in 80 bytes.
>>>
>>> Would changing it to 1024 (MAXREFLEN) fix it?
>>
>> You still need to take ansi codes into account. I think it's easier to
>> just use strbuf.
>
> I'm not sure what you mean. If there was an issue with snprintf, then
> there would be with this in refs.c:
>
>         if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)

I mean GIT_COLOR_BLUE and GIT_COLOR_RESET take some bytes from
"fancy". In the stretched case where ref takes all MAXREFLEN, then
fancy must be a little bit bigger. Why do we need to think hard about
the size of fancy when strbuf would solve it nicely?
--
Duy
