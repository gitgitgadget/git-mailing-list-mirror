From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/7] Make it possible to get sha1 for a path from the index
Date: Tue, 29 Mar 2016 15:32:32 -0400
Message-ID: <CAPig+cQ7GrANpqPxpRAZLyYzO5pNj8ZjF0HX99VkSoJ98TzH8Q@mail.gmail.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257930-17193-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:32:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzNV-0004WC-93
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbcC2Tcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 15:32:35 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36545 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757969AbcC2Tcd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 15:32:33 -0400
Received: by mail-vk0-f65.google.com with SMTP id z68so3619808vkg.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=OeM0cssQlgsu1H1nHX8AD7oudnfAO9oQF6oK/OFvMKg=;
        b=f7fwEf9RIF8V5unCtSdp9iLPoMa3Sj380jhYQUHY7s1MwVoDBXqAaMvHeOgb7Guzvk
         3FUhpygU2r2p7f/SuvoKx1sulLwP2puz6ebgwpGaXl1FeXg8ioFATnOo0DXsEA+baEVP
         vwzFhotv8XnSui7l5aZWMGene/izeQdIHmrIWt57eJHRZXfe94wymI5G/vaVISKtdjeN
         jk6Nurr8+07ElhV9BxPMtgJnyo6YHDbzHM9k/xlQIsLUfHDv90elKXUgmuTwFqZtgOAT
         xo0ScmJ8SZLzk5jhNYu86nCvR1T62w4BebYBBQJuxERSmL0AiNqerhEB1MUpYnlSfNQ7
         qHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=OeM0cssQlgsu1H1nHX8AD7oudnfAO9oQF6oK/OFvMKg=;
        b=F114PCNJ4B5lwueXJH60TY+fvWem2Ti6TahT/tC9VHXOnpWs+FMjPhIa2LbT5dwdje
         O+AeXEb8kBZ9NghQ6iyTxa+pCriHeJrtj8UPfWKccxyjiOeB5GQAsf01CSSJlbTm/EBz
         C7Ax9bhN1V4RpO3UKGK4WYwHB0qewUo4c9kSd4qMHON5ectyIg/nHRGJRD77sVFWz6Sz
         IWaEuhYk9PGTWLzD9qt1C83AThxNUV3mROYRueEsCb6Axon+lsgD5zEaNJdVVOgNU5QL
         j1La+Z2LeE/VWlZpYPeQ/pgurJBSMBv7UfR0WGl/HGHrvBUdXTANbD8NT/o6h+BeI6tU
         DJng==
X-Gm-Message-State: AD7BkJJtBMieMRAzrxSYEovqqdACmImHZcTyPBbcJhSyvEOS5oXAhv+AwZPxZRGFpuYq9uHbBMr5xR0k3fQXCw==
X-Received: by 10.31.150.76 with SMTP id y73mr2562388vkd.84.1459279952293;
 Tue, 29 Mar 2016 12:32:32 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 12:32:32 -0700 (PDT)
In-Reply-To: <1459257930-17193-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: BXP8rFYH9tLsMELcgGovS8CzyqU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290172>

On Tue, Mar 29, 2016 at 9:25 AM,  <tboegi@web.de> wrote:
> Factor out the retrival of the sha1 for a given path in

s/retrival/retrieval/

> read_blob_data_from_index() into the function get_sha1_from_index().
>
> This will be used in the next commit, when convert.c can do the analy=
ze
> for "text=3Dauto" without slurping the whole blob into memory at once=
=2E
>
> Add a wrapper definition get_sha1_from_cache().
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
