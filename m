From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 14:35:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604291429560.9313@virtualbox>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de> <cover.1461837783.git.johannes.schindelin@gmx.de> <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <xmqqshy54j2h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 14:35:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7dm-00067o-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcD2MfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:35:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:62336 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbcD2MfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:35:22 -0400
Received: from virtualbox ([88.128.80.158]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Meduu-1bKF7f1dma-00OH9T; Fri, 29 Apr 2016 14:35:11
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqshy54j2h.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Fw5L4lfg313YrOB8nxYF29MjjUSiy+E6aOEP9896MIiiBjEzQkD
 hCHK8FA4HXtK7aHyKD+g4QmVnCsMw1lhouh2yexdXVbN17WoJPn/fQJ0un4kXOv34SoCc8B
 S+WNzm4l4YfrNnFn15dMnFwQEBhOCzqW6vfgHFe2PmL7VrpKqrveaCwUaI8VxlfDuWhdI77
 cqXUmSeG15OGOhiC49/kQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3eV9qKJI5k4=:owm+i9HjI6VlIIgfVERnoB
 mzacTbNzGiV+//gptQd7JDExTBCEiQfvbllU+4Uy6QbDhGEfaXcGvJLg8j5xIvusMkld6jwV7
 UYgWhQjrBeBQJ9q5lsi3KeBoOkBHUgSo2tFhMQAnUWokRtf8tbi7O+baVmB48kgBHoYIpsg4+
 gAL0K9yXjcBsmFu90Ew8KCxfr/y/KFCPM7Y4v9xicAMXZ1dznnt4SDHr4WnW6Ck0FRJedpmnM
 TQV4ife8TSbf4n+UGEUKyzOO0zfXo3Ns+0pKs/M8NrPqVVP9uaLGCz/A8PpbwZHgwGTcKQgCI
 t0cSK1hm61swbYdhu+0kbP+ZExZ4k8JVBW8MMLa2hg6nboW5lAEDES4gjCZCUE4psl+75f71D
 6OQiCzt+ANRQXlkjXJPV4tTufDeut4ZYqqoml7n7U32xbbfj5QSc4Q4M/xvl7vw/VUw8wwuZl
 GH5BUoy5B0CQex2OJ4dy3nc8hPCmbiecx2Dm9P7VowYAvUISzQFb07NU1UDZqs3btl0ICND1X
 bQib0J6p7TBtSoozJrTX2H23EZ0cjhugBByfaact6+hiUZjrhKGjcSBhzT2itpl08KJ1sVnt8
 l3eegpiJY/PexKHDeEpJUSPsHYBEQYOmqAbvqiixZMPLNXBHn7Uq3DCZ1h0qqGjLYmW/01VnW
 gbyAMhIstlhu9RzeK9MkWm1lM8S5yIXUe34v9lRGP6+L+1hrJxcq76zHQhRgsbCsecT2PMGW0
 YRRMiCXIHew/qT8c8ZDds69Be2GVDB+bIwPgtYqaJQQbAg+OzRxLQEY/bbkfFdMuLU3ZfnZ5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292991>

Hi Junio,

On Thu, 28 Apr 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > -     if (starts_with(var, "credential."))
> > +     if (starts_with(var, "credential.") ||
> > +                     (starts_with(var, "http.") &&
> > +                      ends_with(var, ".extraheader")))
> 
> I know you are fond of indenting with HT without aligning things,
> but this is going too far in the quest of making the code
> unreadable.

Hah. I am actually not fond of anything there, but I go with the default
in my vim when selecting lines and pressing the '=' key...

If you know off-hand how to teach my vim to use your preferred indenting,
I'll gladly just brow-beat it into submission.

>         if (starts_with(var, "credential.") ||
>             (starts_with(var, "http.") && ends_with(var, ".extraheader")))
> 
> would make iteasier to see what are the top-level items (there are two)
> and how they are related (just one of them needs to be satisfied).

Fine by me!

> Assuming that we will discover more variables that can be safely
> passed, I'd rather see the above written like this, though:
> 
>         if (starts_with(var, "credential."))
>                 return 1;
>         if (starts_with(var, "http.") && ends_with(var, ".extraheader"))
>                 return 1;
> 
>         return 0;
> 
> Or even something along this line:
> 
>         struct whitelist {
>                 const char *prefix;
>                 const char *suffix;
>         } whitelist[] = {
>                 { "credential.", NULL },
>                 { "http.", ".extraheader" },
>         };
> 
>         for (i = 0; i < ARRAY_SIZE(whitelist); i++) {
>                 struct whitelist *w = &whitelist[i];
>                 if ((!w->prefix || starts_with(var, w->prefix)) &&
>                     (!w->suffix || ends_with(var, w->suffix)))
>                         return 1;
>         }
>         return 0;

Iff. Iff we go with a white-list.

However, I think you did a really good job arguing that the
CONFIG_DATA_ENVIRONMENT filtering is, in fact, overzealous.

Just let me know what to go with, and I'll update the patch accordingly.

Ciao,
Dscho
