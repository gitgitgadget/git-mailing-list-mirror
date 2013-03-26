From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 21:47:11 -0000
Organization: OPDS
Message-ID: <460E50A0F7A14FA796D6D74E25DA78F3@PhilipOakley>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com> <7vboa7w2vm.fsf@alter.siamese.dyndns.org> <384BCFE976364F1EA6E56306566D003A@PhilipOakley> <20130326094844.GA32583@duynguyen-vnpc.dek-tpc.internal>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Richard Weinberger" <richard@nod.at>,
	"Git List" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:47:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbiQ-00053i-Qw
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab3CZVrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 17:47:06 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:6667 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab3CZVrE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 17:47:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Al8JAPsWUlFOl3N//2dsb2JhbABDhliFP7d9BAGBBheBKoIaBQEBBQgBARkPAQUeAQEhCwIDBQIBAw4DBAEBAQICBSECAhQBBAgSBgcPCAYTCAIBAgMBh3EDE65DgkCGDA2JW4EjiySBNQUWcAsNgicyYQOOMYZWjUyFG4EvgVw8
X-IronPort-AV: E=Sophos;i="4.84,913,1355097600"; 
   d="scan'208";a="404693294"
Received: from host-78-151-115-127.as13285.net (HELO PhilipOakley) ([78.151.115.127])
  by out1.ip04ir2.opaltelecom.net with SMTP; 26 Mar 2013 21:47:01 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219216>

=46rom: "Duy Nguyen" <pclouds@gmail.com>
Sent: Tuesday, March 26, 2013 9:48 AM
> On Tue, Mar 26, 2013 at 08:02:30AM -0000, Philip Oakley wrote:
>> >> Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) whe=
n
>> >> GIT_DIR is explicitly set.
>> >
>> > And it *WILL* be that way til the end of time.  Unless you are at
>> > the top level of your working tree, you are supposed to tell where
>> > the top level is with GIT_WORK_TREE when you use GIT_DIR.  Always.
>>
>> Should this important warning be part of the git(1) documentation on
>> the
>> environment variables (and possibly other places) given the
>> consequences
>> of this case? It wasn't something I'd appreciated from a simple
>> reading.
>
> Something like this, maybe?
>
> -- 8< --
> Subject: [PATCH] git.txt: document the implicit working tree setting
> with GIT_DIR
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> Documentation/git.txt | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7efaa59..ce55abf 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -671,6 +671,8 @@ Git so take care if using Cogito etc.
>  specifies a path to use instead of the default `.git`
>  for the base of the repository.
>  The '--git-dir' command-line option also sets this value.
> + If neither GIT_WORK_TREE nor '--work-tree' is set, the
> + current directory will become the working tree.

I didn't feel this conveyed the Dire Warning effect that would be neede=
d
to avoid the original misunderstanding.

It is easy to miss some of the potential consequences when other
priorities are pressing.

As Junio wondered, perhaps rhetorically, in a later message  "Why do
these people set GIT_DIR without setting GIT_WORK_TREE in the first
place?"

Perhaps
"If the GIT_DIR environment variable is set then it specifies a path to
use instead of the default `.git` for the base of the repository. Note
that the current directory `.` will be used as the working
GIT_WORK_TREE, if not set elsewhere. The --git-dir command-line
option also sets the GIT_DIR environment variable."


>
> 'GIT_WORK_TREE'::
>  Set the path to the working tree.  The value will not be
> --=20
> 1.8.2.82.gc24b958
> -- 8< --
> --
Philip=20
