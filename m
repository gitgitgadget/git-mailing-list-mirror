From: Dan Langille <dlangille@sourcefire.com>
Subject: Re: forcing a user@ into the URL if not present
Date: Tue, 5 May 2015 08:35:57 -0400
Message-ID: <CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
	<CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
	<20150430202342.GC5015@vauxhall.crustytoothpaste.net>
	<CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dan Langille <dlangille@sourcefire.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 14:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypc4y-0003C9-BW
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 14:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbbEEMgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 08:36:00 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38489 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422889AbbEEMf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 08:35:58 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]) (using TLSv1) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVUi5LVIU5OdNVroZps39+M8XCsmyEwwA@postini.com; Tue, 05 May 2015 05:35:58 PDT
Received: by yhcb70 with SMTP id b70so39557196yhc.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcefire.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=cgMWZrtbk9q5Wmxk6tG3fsrS06A6UMkQNWR95JU/JSA=;
        b=SMf7npTUtP7pV/nEwI/UdzrmtG+rbDJyVEmQW6sLLx5NjJwIYeOU0Zhx56yZo2IhLZ
         TehmEZvIg7HiXJuEKTby6vRfIKcym88xu36f61XrZGOuGZN+UbRDFt6CalbY/czh8L2b
         0QKGwItnQ3s2Ewa7t4csGhk/6tY4BUqNLw+no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=cgMWZrtbk9q5Wmxk6tG3fsrS06A6UMkQNWR95JU/JSA=;
        b=brL54mee+eGi/AtxsZsiYqDCwAhyRUqJlH6r16fCoxKDhYSAEeVtYWTaLVPySt+hR8
         xR015FFw5N3VQKmu9shE26KiXi/a8UMw+XkOzJD8JETCcoiq4RvprGbqMUUqIAlcCfnJ
         89zEcfOBeQ3Vu/jTRZ4+OsBz1nufJEpjxeUKGDgB8nljlQKlG6AuGD/aqvgSsB21ppsK
         atGZ6kI3AY85LCUMZUA1MSMdnuQIxLMZA5JewPVQtlrDRgq1sWrnFS3eVZ23JLKES1+K
         Hdcpb3s0c+FJlFHoI9SPRAfIb9UYXKQxrAfgMDiR8o0ScrIleJq+TFO0LwQPIgn1QdHx
         MQxQ==
X-Gm-Message-State: ALoCoQm09EabkwRhrdq3e0m2nbd1W0W0czS2noPC5qcdXCxEwaR2hfbACfOPWhmOk9F7CCeQMc+k894xUuUP+n7K0wihvZZgTPdW4Xc3sKeOqIpaTO49ekU0aDCRXv573AqcwCPsWNAIf+K4UA5XSNH02YZfYKNNTA==
X-Received: by 10.107.27.210 with SMTP id b201mr33408104iob.42.1430829357241;
        Tue, 05 May 2015 05:35:57 -0700 (PDT)
X-Received: by 10.107.27.210 with SMTP id b201mr33408094iob.42.1430829357122;
 Tue, 05 May 2015 05:35:57 -0700 (PDT)
Received: by 10.107.137.95 with HTTP; Tue, 5 May 2015 05:35:57 -0700 (PDT)
In-Reply-To: <CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268392>

On Mon, May 4, 2015 at 3:35 PM, Dan Langille <dlangille@sourcefire.com> wrote:
> On Thu, Apr 30, 2015 at 4:23 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Thu, Apr 30, 2015 at 04:14:12PM -0400, Dan Langille wrote:
>>> Would this question be better suited for another list?
>>
>> Nope, this is the place to go.
>>
>>> On Wed, Apr 22, 2015 at 4:06 PM, Dan Langille <dlangille@sourcefire.com> wrote:
>>> > Hello,
>>> >
>>> > I'm using git 2.3.2 with Kerberos for authentication and gito-lite for
>>> > authorization.
>>> >
>>> > This works:
>>> >
>>> > $ git clone https://dvl@ repo.example.org/git/testing
>>> > Cloning into 'testing'...
>>> > warning: You appear to have cloned an empty repository.
>>> > Checking connectivity... done.
>>> >
>>> > My goal: have it work without supplying dvl@ as shown here:
>>> >
>>> > $ git clone https://repo.example.org/git/testing
>>> > Cloning into 'testing'...
>>> > Username for 'https://repo.example.org':
>>> >
>>> > I don't want to be prompted for a password.  I want Kerberos to kick in.
>>> >
>>> > Following http://git-scm.com/docs/gitcredentials, the following seems to
>>> > have nil effect.  Anyone used this feature already?
>>> >
>>> >   git config --global credential.https://repo.example.org.username dvl
>>> >
>>> > $ cat ~/.gitconfig
>>> > [credential "https://repo.example.org"]
>>> > username = dvl
>>> > [http]
>>> > sslCAInfo = /usr/local/etc/trusted-certificates.pem
>>> >
>>> > With the above, I still get prompted for a password
>>> >
>>> > Given my use of Kerberos for authorization, is this option feasible?
>>
>> Not at the present time.  The only time that the credential API is
>> invoked is if it prompts for a password, and by that point you've fallen
>> back to Basic authentication.
>>
>>> > Should I be taking a different approach?
>>
>> If you want it to work only with Kerberos, then any username in the URL
>> is fine, as libcurl doesn't care.
>
> That is what I found during testing.  So long as I put a username in
> the URL, Kerberos worked
> and all authentication occurred as expected.

As I understand it, in order to invoke Kerberos Authentication, a
username must be in the URL, but that username is not involved in the
authentication process.  Thus, the username in the config is never
applied to any URL and does not not work the same way as a username
which appears in the URL.

I suspect this is because a username in the URL invokes
authentication, which prompts the whole Kerberos process.

The best workaround I've found is this configuration item:

[url "https://FOO@repo.example.org"]
        insteadOf = https://repo.example.org

We'd be happy if we could set this as a global config setting and not
have the users prompted for a password. The whole beauty of Kerberos
is not getting prompted for stuff.  Am I simply failing to comprehend
the steps involved in Kerberos Authentication?

What bits of code would need looking at in order for git
authentication to work seamlessly with Kerberos? We are so close.

-- 
Dan Langille
Infrastructure & Operations
Talos Group
Sourcefire, Inc.
