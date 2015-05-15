From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Show all branches and ahead/behind states
Date: Fri, 15 May 2015 09:25:22 -0500
Message-ID: <CAHd499Am4PFo-YRJEbQfPqtk571f4eNr_gkdy-3ATzyvBcc-jw@mail.gmail.com>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
	<1431618938.31573.3.camel@kaarsemaker.net>
	<CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
	<1431624587.31573.5.camel@kaarsemaker.net>
	<CAHd499BoApGJSM_qEKG8cHNOV_pOCyPRqEAXHo8iqYVg1LpGdw@mail.gmail.com>
	<20150514223827.GB21149@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 16:25:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGYL-0003rZ-16
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbbEOOZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 10:25:25 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36847 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbbEOOZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:25:24 -0400
Received: by igbpi8 with SMTP id pi8so221977531igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Tlw0U1z0hpo4n7fHRAk2tWAYmRxfe1xw3OjZDlh52aA=;
        b=XnIlpO2OPD21mz9QxyInDuAJyScwQNq75y3LlYoXRlIA4BAfmmgBTsfk4xe/gaCYeR
         KMJr7DiYEDmjjydsL0APxD+fY4OhuqJ0qtPPNPYKn0+5uKiwQDy5GtnXs4z/54Zr4RM4
         Rw8BUq/cDGPVxkUvOeseW48KmG037IT30FBSiT8VSncf/EOsaVQfkITFfKpoebvDi9i9
         5TU5aRPAjpE22FVtZgRoNztzINIU2QA45m8vZgt2MCGXIk4/+S0vKbzxTIWX2vORnvRy
         Al0zYBNm8MtOrwNQW0nG0HgE5D8p+BSeycmtGJrjerk34AOUZIcBNJ1GNu7bjNiCI+j/
         4kbA==
X-Received: by 10.50.142.67 with SMTP id ru3mr25739324igb.40.1431699922341;
 Fri, 15 May 2015 07:25:22 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Fri, 15 May 2015 07:25:22 -0700 (PDT)
In-Reply-To: <20150514223827.GB21149@peff.net>
X-Google-Sender-Auth: e-eSsMAArWXCdmjw5jXSg6n4L78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269144>

On Thu, May 14, 2015 at 5:38 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 14, 2015 at 01:13:15PM -0500, Robert Dailey wrote:
>
>> > git for-each-ref --format '%(HEAD) %(refname:short) %(upstream:short) %(upstream:track) %(subject)' refs/heads
>>
>> Great idea. For some reason I can't apply coloring though:
>>
>> for-each-ref --format '%(HEAD) %(refname:short) %C(bold
>> blue)%(upstream:track)%C(reset)' refs/heads
>>
>> Output:
>>
>> hotfix/4.2.3.1 %C(bold blue)[ahead 1, behind 1]%C(reset)
>
> It's spelled "%C(bold blue)" in the --pretty formats, but in
> for-each-ref, it's "%(color:bold blue)". Unifying these is one of those
> things that has been on the radar for a long time, but nobody has quite
> gotten around to it.
>
> -Peff

Thanks Jeff! That definitely fixed it. I was not able to find a
reference for this in the git docs, maybe I just overlooked it
somewhere.

As a second query, is there a way to do column alignment? For example,
I would like the ahead/behind status in one column, and the branch
names left aligned in a 2nd column. I can't simply use tabs here since
the length of column 1 may differ more greatly than a single tab
character.

I imagine there is no built in way to do this, but just curious. I'd
probably end up having to write some complicated script :-(

Thanks again you've been super helpful.
