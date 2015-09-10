From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1 0/2] git-p4: work on a detached head
Date: Thu, 10 Sep 2015 13:23:58 +0100
Message-ID: <CAE5ih78sVaPQ_=v5ceTZjV+iJCQOy=R_Z_trOHYUPrEMHn5zzQ@mail.gmail.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
	<6B07CAFE-6A10-481A-9D15-0DBFF6AB0B11@gmail.com>
	<CA+P7+xqZ+MOMN6so1AVSbQdHjuWp+48jQw8gp8cxE0CaYc8Ldw@mail.gmail.com>
	<CA+P7+xqTGR4EfQGmOyvB=hS5YNS1hnhddFRqdjXp+DiTSbMdRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 14:24:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za0ta-0000Zc-5D
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 14:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbbIJMYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 08:24:01 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:34720 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbIJMX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 08:23:59 -0400
Received: by obbda8 with SMTP id da8so32768529obb.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9kbm6AfjoCad4uQreLplcaynbFTp8OffdbqtsHCv2ig=;
        b=B9JwR3YReHrrHlUhuusLJogU4v+1bCm9bauDDK0Q1Wlh4Ea17Pgv+dw97dFCDgU2eb
         25RUoOKmGLmEiccDeBW5RXNQOHBRLGxbg3jpdUhCX/VEPS5rqTYEYnoZ5bYY2Y13qncM
         bsc3k5tIGP/dH1GmYTSqz0E4ANbMdAGMtrtVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9kbm6AfjoCad4uQreLplcaynbFTp8OffdbqtsHCv2ig=;
        b=ArZPBzZGQoXPCh7Hcv14CdFMwwCjFCCrUc4eomuZP+0vpnK7d/OrhehbSkBMjGHWBh
         OTaIsQB6b1j6CDDKFICRE3XjUEanIqdqQHYE8g/BLVOhU12iHNyHIj2SExQLL6ECVgpa
         dO9QWNSJFHrOe5WdXvwXXjrxMgAZwNZ6Dy3Wp+NfXeiUwH6QPf3F1zvkanOdWeiL+lxS
         cTaq48Hbspd8l+6Bkyno+84NoYtutQ3PA3m0vdOYw3lTCJtBeDhNnrMcWwQsDqPyuIal
         CCmEBL/+bUyVFjLTFRQkqM38PT1eetmMzowNTwBCOS0AZrIyAJp1R2iIiSbfdvZ/14tB
         DwRA==
X-Gm-Message-State: ALoCoQlt/s7tOHQhp6jQ9UP/vCT9kyHf1Q7b3SUviao1o+RAt97rRt051jL73ZN8yH623gFg4651
X-Received: by 10.60.175.71 with SMTP id by7mr24145652oec.58.1441887838795;
 Thu, 10 Sep 2015 05:23:58 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Thu, 10 Sep 2015 05:23:58 -0700 (PDT)
In-Reply-To: <CA+P7+xqTGR4EfQGmOyvB=hS5YNS1hnhddFRqdjXp+DiTSbMdRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277579>

On 10 September 2015 at 02:59, Jacob Keller <jacob.keller@gmail.com> wr=
ote:
> On Wed, Sep 9, 2015 at 6:57 PM, Jacob Keller <jacob.keller@gmail.com>=
 wrote:
>> On Wed, Sep 9, 2015 at 5:03 AM, Lars Schneider <larsxschneider@gmail=
=2Ecom> wrote:
>>> I wanted to play with the patch and apply it to my source but the p=
rocess is really complicated for me. I wonder if you can give me a few =
recommendations how to work efficiently with email patches. I don=E2=80=
=99t want to start a flame-war about what email client is =E2=80=9Crigh=
t", I am just curious how you work and what clients, scripts, or tricks=
 you use :-)
>>>
>>> Usually I use Apple Mail. I experimented with mutt but it was not d=
ramatically more convenient.
>>>
>>> Thanks,
>>> Lars
>>
>> Generally, any client which lets you save patches as mbox format. Th=
en
>> you can feed the file via git-am
>>
>> I don't know what clients make this easy. I normally use Evolution,
>> which has as "save as mbox" option. It's possible Apple Mail does to=
o.
>>
>> Regards,
>> Jake
>
> For the record, you can use "show original" from GMail, and save that
> file as well, I believe. I don't know about Apple Mail specifically,
> however.

I also don't use Apple Mail, but it must surely have a way to get the
original email text. Save that and then do:

$ git am /path/to/saved-file


At least, that's what I do.

Luke
