From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Sat, 1 Jun 2013 10:48:35 +0200
Message-ID: <CALWbr2w0rX3kY4doR3twzSpR5AL7gejtMpNZo_x=S1e25Ytwew@mail.gmail.com>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
	<51A2722A.8040200@kdbg.org>
	<CALWbr2xzSC8ZGggCUYbS7ZWEOHnZnxFJWOfHCOBkVZFQS9KcEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 01 10:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UihUi-0006LW-07
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 10:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3FAIsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 04:48:40 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:42108 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab3FAIsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 04:48:38 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so2379913lbd.20
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PkCASo1H1uyqQEwmEWq1IroNGRjjDfW6Lf9HhE4+T1Q=;
        b=CzC+QLYh2V1WGMdCmRmU6IdpcPJjv2c01yF7uI6iu24zRmsmIKMIifozahyxkP/Mvf
         faHACf0L/Cw/Jl/En1ZA4pD7OgXv7D0u2Q9mh6WUDGAlnnyEsNTP6DrrnSxb+xxJh7Ba
         G4hw2p8IcrhvCNau2/rsSgkuXFZVgWnAu6sXOGdRiihZu4qsIYvVRHpmKPTDeGxrxRGZ
         9ZjG0sni7lBkj7LykBdm/2ZH4q/9OyVfdW4MqVw4kaII+E9FWTSQZOzZGDLiFPU+daZz
         cXpWPF06h3D/yJ+TwDfG6d09YTwZM4L0Pov+Zx/m4tjKNf9wVMKkQpVn7aZnMPDNuL+/
         DOIQ==
X-Received: by 10.112.151.8 with SMTP id um8mr984527lbb.87.1370076516034; Sat,
 01 Jun 2013 01:48:36 -0700 (PDT)
Received: by 10.112.61.8 with HTTP; Sat, 1 Jun 2013 01:48:35 -0700 (PDT)
In-Reply-To: <CALWbr2xzSC8ZGggCUYbS7ZWEOHnZnxFJWOfHCOBkVZFQS9KcEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226104>

On Mon, May 27, 2013 at 9:14 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Sun, May 26, 2013 at 10:35 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> I'm thinking of diffs of files with CRLF
>
> Good you did, because I didn't ;-)
>
>> line breaks, where the CR would count as whitespace in the line, I think.
>
> With the current implementation, an empty line with CRLF will not show
> as a blank line if no space option is given. As CR is a space
> according to isspace(3), the line will be removed with any space
> option.

Maybe it would be worth adding the diff(1) "--strip-trailing-cr"
option. So that you could remove empty lines if you have dos line
endings while caring about eol space-changes (or other space changes).
