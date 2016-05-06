From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Fri, 6 May 2016 12:18:38 -0700
Message-ID: <CAGZ79kaJYngaZfhx060C06J57aDqPJfdMD8xzK4dW4nvvktMLQ@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
	<CAGZ79kaBh-SogYrMcVfgE1DS464oK2Z01ZqpBiM0eSHKMPU1Fw@mail.gmail.com>
	<xmqqr3df2end.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, felix@debuggable.com
X-From: git-owner@vger.kernel.org Fri May 06 21:18:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aylGu-0003sU-Vz
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 21:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322AbcEFTSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 15:18:40 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34739 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144AbcEFTSk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 15:18:40 -0400
Received: by mail-ig0-f176.google.com with SMTP id u5so8099996igk.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=pUqCA1m4mb9YJ4q+v9r3eIpPe0Z7PBR8Z9FdJNPzaxI=;
        b=f9o+QRSFVvjc3zleVRiEUqMSFT2hyI/Xt9YhN2SFFyrguMu95ioDceLmkHLdKepNao
         qBmIXw8OYgOxRVBLhiYaS+AwzvMHpCttxJTdjEB3mrlyoeUSmm+Ko6oPTf/7cFzF+9WL
         yGcRODQkNZc83wv8vKW59mWA2teuNxbZ00WrTuQd/5AypXqxTvVKdE2JTnjRbCj6kiDe
         64cj72vv2mvrat8+pQlu+8oAVIi+8JfSNm3kXxVfS0Es8w0AHzjz4b4DeLE0NN3hzrax
         EIaLoOUBWkj8sx9vwyXzbWDPEx9HzSasDkkDceKac+rwQ/f4HCtbkfhmOjB+xgauV1JU
         GsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pUqCA1m4mb9YJ4q+v9r3eIpPe0Z7PBR8Z9FdJNPzaxI=;
        b=hSWRLBVEfTjndHrsAisFgjDH8w/upBkhovL+Odx8DDaJa5uBE8pZ9/4NmZD2aHDSX5
         rB+iHEXGUMCdfovEbzi3xmEnqpwm6aW1cgKRBPCX51Pyd2w8DsS0Ukguj9AtVfoBMI/Q
         JafbCEC131GZDcrMFVbJiGW3sDXIZM2lhvrq9ilJxQ/9grvxI9aVzUjXGoqpFhpXc8nH
         gts3S8NzRq49DhJK80UksizTbqFAL5M+fUBq/E2fSYeaAmPb+jnTsVsdbaa7WKCL9fA5
         hCssA1eHPKybrZrId74Iagfpdr4JETS5G1Z2Tb1kzv+eo4cIbmtI5aqhw8b0u/2oe+bL
         TEYw==
X-Gm-Message-State: AOPr4FUbh3/n+0ZYwQAw1rEGF7nyLLrYCwIH58OBu6TtuqGbJnjuw2e9ntvBczmnb0SWtiOnPcEnShFJQ6XWizkh
X-Received: by 10.50.29.45 with SMTP id g13mr12429528igh.93.1462562318983;
 Fri, 06 May 2016 12:18:38 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 6 May 2016 12:18:38 -0700 (PDT)
In-Reply-To: <xmqqr3df2end.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293850>

On Fri, May 6, 2016 at 12:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, May 6, 2016 at 3:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Fri, May 6, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>
>>>>>> I wonder if the patches mentioned have something to do with the "git
>>>>>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>>>>>> repository in some way?
>>>
>>> The same functionality is added in 8745024 (parse_pathspec: support
>>> stripping/checking submodule paths - 2013-07-14) so if it didn't fail
>>> to notice that before 5a76aff1a6 and did after, it's a bug.
>>
>> The bug seems to have existed before. However in the bug we are talking
>> about the nested repo is not a submodule yet.
>
> That agrees with Duy's recollection below:
>
>>> I vaguely recall this symptom. It has something to do with the index,
>>> the check we do requires a gitlink in the index, I think. So if the
>>> gitlink entry is not in the index, our protection line fails.
>
> So are we all on the same page that this is a bug now?

It was a bug, but now people in the outside world consider it a feature.
Search for "Git fake submodules" and you'll find a few users who use this
technique successfully.

I do not think fixing this bug would do good. So maybe we just let it slip?
