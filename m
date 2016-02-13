From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 0/3] config: add '--sources' option to print the source
 of a config value
Date: Sat, 13 Feb 2016 18:26:51 +0100
Message-ID: <CAHGBnuOu4wWYLkYZdgHuaM4D0Ay8J3xNb1towtTj7FcLK1zVdw@mail.gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
	<CANoM8SWj08qKvDXhyfRXLV2iuYJ7Vjdutzjt0Q2ZNOcProqy=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: larsxschneider@gmail.com, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, ramsay@ramsayjones.plus.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 18:26:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUdyD-0000wQ-BT
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 18:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbcBMR0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 12:26:53 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34276 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbcBMR0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 12:26:52 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so6012259vkh.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NA17r8nL5x+aBFiHFnoUDYbvzOKIA4KABIM8GtSwnB8=;
        b=M6vRimNyzX9x23gj/uyBMfQ1pbwXCY6QYEbJ5pJBYW7zOE4UKgFHuQyDtPIqID+ELM
         A9OLG+R3qcPAvsqjdTeZAwFZKK8js8sWIOCnCEqoBkKy/lsoVbig8S3kQqj1ckjHor8R
         eFeFWPkKUJm+2zZf2yL/6yCKbnewqnDR654SoePIVSNdm+7SmA0KS+hm7FSB4ezFk6e1
         qer3dhqDz9GwYLTEtM9PD4xCfB2tmfasK1nqHiAzZwP3P5WNCWbT9d51AUpXLRVMA5j0
         DzNHBk+muZqu9vC9MSUCqXf3PFpjzjb4YeBaVG7hCEudwcsho6M7Ckb6+3e55vMXsJ99
         RQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NA17r8nL5x+aBFiHFnoUDYbvzOKIA4KABIM8GtSwnB8=;
        b=X2wOPuc8JaPDieLQLYEqnQvKsNQYHj4hjm9hjAF1AQYaLKcBuCiQ+1O/6wLKf1pUZC
         3cb2WWsfpLUIrLIAGCD7ag9no3F8aF97BBE8WnJJbfHQas9veXHjymPy6og4l9cGK2uP
         9VGcKF9VKktHKvcqtrd5stZCLy4burQKk3D3sdPJkqW54gfFQaUWbQXRVzQ11mskyxMn
         wiQA9i8PkbRQpG5JV2uEpF4cJ9aWbJahlGt6XOtvYEqfgFGOWYF668yAGZERxZDJIBSt
         KoKrjkb2VSMrDy0RF9X+QrDcJlKb3JZJcQYgIcsvTXWrzU0fnSpoMXYtw5xPy37kvEfX
         zSTQ==
X-Gm-Message-State: AG10YOTXPJMa+crZ8PfiGTyK4nyMJ2GAFQHSHrNFOFVWCDAWIaII21NMMXolW5Kdr/TUGGUBhZSxarGDDj1vAw==
X-Received: by 10.31.146.2 with SMTP id u2mr5653298vkd.19.1455384412015; Sat,
 13 Feb 2016 09:26:52 -0800 (PST)
Received: by 10.176.68.6 with HTTP; Sat, 13 Feb 2016 09:26:51 -0800 (PST)
In-Reply-To: <CANoM8SWj08qKvDXhyfRXLV2iuYJ7Vjdutzjt0Q2ZNOcProqy=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286120>

On Sat, Feb 13, 2016 at 3:43 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:

>> I renamed the flag from "--source" to "--show-origin" as I got the impression
>> that Sebastian, Peff and Ramsay seem to be all OK with "--show-origin".
>
> I know that I am late to the party here, but why not make the option
> `--verbose` or `-v`?  `git config` doesn't have that now, and this
> seems like a logical thing to include as verbose data.  I would

`--verbose` would be fine with me.

-- 
Sebastian Schuberth
