From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] 64bit issue in test-parse-options.c
Date: Wed, 30 Jul 2008 21:55:00 +0200
Message-ID: <20080730215500.5b4ec69e@pc09.procura.nl>
References: <20080730141656.41ce02ec@pc09.procura.nl>
	<20080730123713.GA31392@artemis.madism.org>
	<20080730144452.797d8686@pc09.procura.nl>
	<20080730140523.GC31392@artemis.madism.org>
	<7vej5b5grc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHnB-0001tP-MM
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbYG3Tzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbYG3Tzc
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:55:32 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4564 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313AbYG3Tza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:55:30 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UJt0Fm086493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 21:55:01 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vej5b5grc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90844>

On Wed, 30 Jul 2008 12:11:35 -0700, Junio C Hamano <gitster@pobox.com>
wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > The proper fix is to let integer be an *INT* (long integer is bogus
> > anyways) and to put the date in a long using static unsigned long date,
> > and make OPT_DATE use this long.
> 
> I am still puzzled by the original report of the breakage, as H. Merijn
> cannot be the first person to ever ran test-parse-options on 64-bit
> machine.  Maybe there is a bytesex issue involved as well?

Itanium 2 / 64, and endianness indeed

> In any case, this should work.

Yes, that was what I was thinking too, but I had no time to go for the
test cases too. I had it to get to work ASAP.

>  test-parse-options.c     |    8 +++++---
>  t/t0040-parse-options.sh |   11 ++++++++++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 2a79e72..6e18083 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -2,7 +2,8 @@
>  #include "parse-options.h"
>  
>  static int boolean = 0;
> -static unsigned long integer = 0;
> +static int integer = 0;
> +static unsigned long timestamp;
>  static int abbrev = 7;
>  static int verbose = 0, dry_run = 0, quiet = 0;
>  static char *string = NULL;
> @@ -32,7 +33,7 @@ int main(int argc, const char **argv)
>  		OPT_INTEGER('i', "integer", &integer, "get a integer"),
>  		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
>  		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
> -		OPT_DATE('t', NULL, &integer, "get timestamp of <time>"),
> +		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
>  		OPT_CALLBACK('L', "length", &integer, "str",
>  			"get length of <str>", length_callback),
>  		OPT_GROUP("String options"),
> @@ -56,7 +57,8 @@ int main(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, usage, 0);
>  
>  	printf("boolean: %d\n", boolean);
> -	printf("integer: %lu\n", integer);
> +	printf("integer: %u\n", integer);
> +	printf("timestamp: %lu\n", timestamp);
>  	printf("string: %s\n", string ? string : "(not set)");
>  	printf("abbrev: %d\n", abbrev);
>  	printf("verbose: %d\n", verbose);
> 
> 
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 03dbe00..e38241c 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -47,6 +47,7 @@ test_expect_success 'test help' '
>  cat > expect << EOF
>  boolean: 2
>  integer: 1729
> +timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 2
> @@ -63,6 +64,7 @@ test_expect_success 'short options' '
>  cat > expect << EOF
>  boolean: 2
>  integer: 1729
> +timestamp: 0
>  string: 321
>  abbrev: 10
>  verbose: 2
> @@ -88,6 +90,7 @@ test_expect_success 'missing required value' '
>  cat > expect << EOF
>  boolean: 1
>  integer: 13
> +timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 0
> @@ -108,6 +111,7 @@ test_expect_success 'intermingled arguments' '
>  cat > expect << EOF
>  boolean: 0
>  integer: 2
> +timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> @@ -135,6 +139,7 @@ test_expect_success 'ambiguously abbreviated option' '
>  cat > expect << EOF
>  boolean: 0
>  integer: 0
> +timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 0
> @@ -161,6 +166,7 @@ test_expect_success 'detect possible typos' '
>  cat > expect <<EOF
>  boolean: 0
>  integer: 0
> +timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> @@ -177,7 +183,8 @@ test_expect_success 'keep some options as arguments' '
>  
>  cat > expect <<EOF
>  boolean: 0
> -integer: 1
> +integer: 0
> +timestamp: 1
>  string: default
>  abbrev: 7
>  verbose: 0
> @@ -197,6 +204,7 @@ cat > expect <<EOF
>  Callback: "four", 0
>  boolean: 5
>  integer: 4
> +timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> @@ -223,6 +231,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
>  cat > expect <<EOF
>  boolean: 1
>  integer: 23
> +timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0


-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
