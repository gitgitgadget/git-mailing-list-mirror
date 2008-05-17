From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 00:30:40 -0300
Message-ID: <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
	 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat May 17 05:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxD9M-0004IC-Up
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 05:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbYEQDan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2008 23:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbYEQDan
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 23:30:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:29550 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYEQDam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 23:30:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so918141fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 20:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=f2A/pHN1C7aBmyI8uE3duG0N0xEpmIZoo+ixa/Q+OIQ=;
        b=H5hbuW0+e7joEPHPQG7VM7iCrizUcNmG2vjnytT0pwGcUIPhGzRcFif/Us8dovyMtV/Q8JMiZvu7yRIUUVABuWYmNnshw/Fi4jMQFFdE0G0RG8RbR86JpUIKuZVzpGNlAQ9nNIqo98gFKTe5Ukz24Ka12kwo8z6B5An/gETgQnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lhI+gt8p/WStcPvsXg4B8xssuyZY9uuIcDrWShivAXYd/EOf+XoKRet3ApFuLkw89be+mwM20PdzdWsRgqzU/Ox27MCA3/zRqBcVNibcuYlYQY8kqSAcLYjC0y5tsZwnmben8njuc5Rwk8tz4b9FxX5ZalJ+6nmSNqfXWvhwEHo=
Received: by 10.78.124.7 with SMTP id w7mr1186618huc.60.1210995040295;
        Fri, 16 May 2008 20:30:40 -0700 (PDT)
Received: by 10.78.120.2 with HTTP; Fri, 16 May 2008 20:30:40 -0700 (PDT)
In-Reply-To: <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82333>

On Fri, May 16, 2008 at 2:12 PM, Kevin Ballard <kevin@sb.org> wrote:
> On May 16, 2008, at 6:25 AM, Johannes Schindelin wrote:
>
>> On Thu, 15 May 2008, Andr=E9 Goddard Rosa wrote:
>>
>>>>> This patch will make git a little more human friendly, reporting
>>>>> "file.txt: has local changes".
>>>>
>>>> Documentation/git-checkout.txt should also change in this case,
>>>> otherwise users will see different output to that described and
>>>> possibly get confused if following along with the examples.
>>>>
>>>
>>> I like the idea too.
>>
>> No comment on the concern that it might break people's scripts?  Non=
e?
>
>
> How about an ugly hack? Look to see if stdout is a tty, if so spit ou=
t the
> more human-readable version, otherwise spit out the old version >:-)

Is this user interface set on stone? I think we should reserve the
right to improve always.

I would deprecate the current message, but I think that most users
cannot find so much of a sense in the former message,
although the script developer can easily change his scripts to search
for =B4cannot merge=B4 instead.

Do you have a better idea?

---
[PATCH] "not uptodate" changed to "has local changes"

Use more straightforward message for regular user.

Signed-off-by: Andre Goddard Rosa <andre.goddard@gmail.com>

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index a644173..624dea6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -168,7 +168,7 @@ the above checkout would fail like this:
 +
 ------------
 $ git checkout mytopic
-fatal: Entry 'frotz' not uptodate. Cannot merge.
+fatal: Entry 'frotz' not uptodate, it has local changes. Cannot merge.
 ------------
 +
 You can give the `-m` flag to the command, which would try a
