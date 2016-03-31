From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 19:54:47 +0530
Message-ID: <CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
References: <20160331123507.GC19857@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@collabora.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:24:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldWn-0003rE-4h
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbcCaOYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:24:48 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35500 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcCaOYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:24:48 -0400
Received: by mail-yw0-f177.google.com with SMTP id g127so99117045ywf.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2wYFyZsCIDmTDDa38fL7QtJ1rRBH//cRNPiDv6l5aQM=;
        b=zZ6EHa5SscBXxUR/mLM+ODZjUkuilPU/W+YqmTg1qKNICuhL5+BOn/8kWw5WA5Apld
         32dqbhaSVDvI4Wlo2Qr7c1UX6e147ZD44SJahdYoxwDM4Jfe42H2TBYkT5FHFgHKh0NL
         mkNYWsCJq9yzx8ws5ao8tF7cGcCI52k/H7815HWCEiabF8NOkkpO9NPQlKkjNNOSgxa2
         iha5GdeKUJGPkF+BCYWFget8306oP/XgvWFY0EDmqhm01vyOC2zReGOhAUtREEPpyzKV
         sS2TaW3WlNY/HI4exco6PgD0a0tqNgJY82ffplyzbWtc++K8VhCkM6sdaOmzogZ0m0Ab
         /CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2wYFyZsCIDmTDDa38fL7QtJ1rRBH//cRNPiDv6l5aQM=;
        b=hZ4bK22F72ZGr8GMDnV4UBCGYrxwoYgmNURe6Y8QqIvMMP0IMtjRvaShYN18ZB99QN
         C3UIHUXKJgVGChL/bdPfvE+kj0fFbdZlGPtqlmCCt8CH7600cOTFfUya9Cq2/jwM1RoT
         yVYySmO+FyTOx8pbXzr5hHFHUeQYYiTIvHDJs4oST9ujdARxV/Bl8FNBHaaQbK8C3j7g
         HK6kujjjdK4OznUOrqM+tZja7JqzKmdBZi4WAy5S4mk1OF1VufFsgIqJlq6ErKsXSOtk
         zXwkGcl4vrLMYehSUkYttxt3TKI9S9RzO0JqHMptnBvc6ksdc4XyTy0/dIataZ13945l
         0oeg==
X-Gm-Message-State: AD7BkJKOFOIY0YD3+5b/tkkzvGSJV93m9ONlQJUFpE5XY4ARmOM6Q08l7AR/g2oiu7TTEPTB9CJbyeH9SyFH+g==
X-Received: by 10.129.9.214 with SMTP id 205mr7515513ywj.53.1459434287311;
 Thu, 31 Mar 2016 07:24:47 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 31 Mar 2016 07:24:47 -0700 (PDT)
In-Reply-To: <20160331123507.GC19857@collabora.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290387>

On Thu, Mar 31, 2016 at 6:05 PM, Miklos Vajna <vmiklos@collabora.co.uk> wrote:
> Hi,
>
> Some projects like LibreOffice don't use Signed-off-by, instead usually
> use Gerrit for code review, and reviewers add a Reviewed-by line when
> they are OK with a patch.  In this workflow it's a bit unfortunate that
> adding a Signed-off-by line is just a command-line switch, but adding a
> Reviewed-by line is more complex.
>
> Is there anything in git that could help this situation? I didn't see
> any related config option; I wonder if a patch would be accepted to make
> the "Signed-off-by" line configurable, or there is a better way.

Actually there is a "related" config option format.signOff (more about
this in Documentation/config.txt) which is a boolean.
But that will only enable the "-s" by default.

> Like, would a patch that adds e.g. a core.signedOffString configuration
> option to make the string customizable welcome?

Are you suggesting to use a different email address for commiting,
signing off and reviewing?

> Thanks,
>
> Miklos
