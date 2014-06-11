From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 11 Jun 2014 17:48:31 +0700
Message-ID: <CACsJy8Cgu792Tamej3+_9w=Krg8nezYYA6k604gikebHG=yVUg@mail.gmail.com>
References: <1401912909-29654-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8AyvkA20mD283=hWp7WFJXBu3-ViXHuS4jtMzz2hpBi2Q@mail.gmail.com> <CAKpPgveXen9sQefo8dva1Uy4YOyroT6cPXLzgUvxj93Zqw13zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 12:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wug5d-0001kL-QN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 12:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbaFKKtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 06:49:04 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:55952 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbaFKKtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 06:49:02 -0400
Received: by mail-qa0-f43.google.com with SMTP id k15so2073165qaq.16
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CflW3lpGW6nUMWh4aHo0zFWAdJRlhl7S59WZ4SX8KQ4=;
        b=rNVa4LLgYFi/v8b5O5vN7hSeTELApZAIoUcSGFkI3dB3flYB49NoQAb8wmOIjgXQqs
         L2WjdBzvrD5kkYdoXZgVl4vPNlCg23qK/EIKiJkdFGswSRazCh7R4eezqE1WPpdbM7dk
         duxU0b+qpQD1YU1UT4SHvAeobfVWxgJZ0Io58eGmxqKilbdZVmwfgDUqQ1u1m4oVM0bK
         3IdrQAqDN7DPd5CBt1r0Lqop+Sg11QeYYgmmOk8Ej+l4aSXJgPtRxdu8dUSG9pUvhzId
         PIc+sSL0OuBO2R0DHL8NUKIHcauJC7leaQTpMdtr7fb5hWwjEFHH1g3ueZt82AgH+JC4
         R88g==
X-Received: by 10.229.93.133 with SMTP id v5mr13000302qcm.1.1402483741834;
 Wed, 11 Jun 2014 03:49:01 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 11 Jun 2014 03:48:31 -0700 (PDT)
In-Reply-To: <CAKpPgveXen9sQefo8dva1Uy4YOyroT6cPXLzgUvxj93Zqw13zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251359>

On Tue, Jun 10, 2014 at 10:18 AM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
>> On Thu, Jun 5, 2014 at 3:15 AM, Pasha Bolokhov <pasha.bolokhov@gmail.com> wrote:
>>> +       /* only add it if GIT_DIR does not end with '.git' or '/.git' */
>>> +       if (len < 4 || strcmp(n_git + len - 4, ".git") ||
>>> +           (len > 4 && n_git[len - 5] != '/')) {
>>
>> Hmm.. should we exclude "foobar.git" as well?
>
>     Why wouldn't we? Everything that has basename ".git" is hard-wired
> to be excluded, but everything else, including "foobar.git" should be
> added to the excludes manually... How is it better than just "foobar"?

Yes everything except ".git" should be excluded. And you do exactly
that. I misread the code (probably better to write "if (!(<basename is
".git>))", maybe)
-- 
Duy
