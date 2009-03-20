From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Fri, 20 Mar 2009 13:13:23 -0700
Message-ID: <7vbprwgdgc.fsf@gitster.siamese.dyndns.org>
References: <20090318100512.GA7932@linux.vnet>
 <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de>
 <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com>
 <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302>
 <20090320064813.6117@nanako3.lavabit.com>
 <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkl7P-0002lv-OC
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZCTUNe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 16:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZCTUNe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:13:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZCTUNd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 16:13:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EAE7FA3968;
	Fri, 20 Mar 2009 16:13:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 24CF7A3964; Fri,
 20 Mar 2009 16:13:24 -0400 (EDT)
In-Reply-To: <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com>
 (Allan Caffee's message of "Fri, 20 Mar 2009 15:13:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94D5FF42-158B-11DE-997D-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114001>

Allan Caffee <allan.caffee@gmail.com> writes:

> On Thu, Mar 19, 2009 at 5:48 PM, Nanako Shiraishi <nanako3@lavabit.co=
m> wrote:
>> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>>> I'd start like this:
>>>
>>> =C2=A0 =C2=A0 =C2=A0 enum color_name {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_RESET,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_RED,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_GREEN,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_YELLOW,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_BLUE,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_MAGENTA,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_CYAN,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COLOR_WHITE
>>> =C2=A0 =C2=A0 =C2=A0 };
>>
>> Looking for "COLOR_RED" in the archive gives:
>>
>> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/109676
>>
>
> Duly noted.  Perhaps those #defines should be relocated to color.h?

Heh, I did not even realize the above 109676 was referring to what I wr=
ote
sometime ago.

> If we still wanted to provide a color_name type we could use
> GIT_COLOR_NAME_RESET et al.  That would give us something like:
>
> #define GIT_COLOR_NORMAL	""
> #define GIT_COLOR_RESET		"\033[m"
> #define GIT_COLOR_BOLD		"\033[1m"
> #define GIT_COLOR_RED		"\033[31m"
> #define GIT_COLOR_GREEN		"\033[32m"
> #define GIT_COLOR_YELLOW	"\033[33m"
> #define GIT_COLOR_BLUE		"\033[34m"
> #define GIT_COLOR_CYAN		"\033[36m"
> #define GIT_COLOR_BG_RED	"\033[41m"
>
> enum color_name {
> 	GIT_COLOR_NAME_NORMAL
> 	GIT_COLOR_NAME_RESET,
> 	GIT_COLOR_NAME_RED,
> 	GIT_COLOR_NAME_GREEN,
> 	GIT_COLOR_NAME_YELLOW,
> 	GIT_COLOR_NAME_BLUE,
> 	GIT_COLOR_NAME_MAGENTA,
> 	GIT_COLOR_NAME_CYAN,
> 	GIT_COLOR_NAME_WHITE
> 	GIT_COLOR_NAME_BG_RED
> };
>
> /*
>  * Map names to ANSI escape sequences.  Consider putting this in colo=
r.c
>  * and providing color_name_get_ansi_code(enum color_name).
>  */
> const char* git_color_codes[] {
> 	GIT_COLOR_RESET,
> 	GIT_COLOR_BOLD,
> 	GIT_COLOR_RED,
> 	GIT_COLOR_GREEN,
> 	GIT_COLOR_YELLOW,
> 	GIT_COLOR_BLUE,
> 	GIT_COLOR_CYAN,
> 	GIT_COLOR_BG_RED,
> };
>
> That conveniently offers clients access to both the raw escape codes =
and
> a clear type for storing/handling colors.

Is git_color_codes[GIT_COLOR_NAME_FOO] supposed to give you GIT_COLOR_F=
OO?

Are you consolidating various pieces of physical color definition to on=
e
place?  That sounds sensible.

The corrent code does:

diff.c::
	user says "meta" is "purple"
        -> parse_diff_color_slot() says "meta" is slot 2
        -> git_diff_basic_config() asks color_parse() to place the ANSI
           representation of the "purple" in slot 2
	-> code uses diff_get_color() to grab "meta" color from the slot
           and sends it to the terminal

builtin-branch.c duplicates the exact same logic with a separate tables
and a set of slots.  builtin-grep.c cheats and does not give the end us=
er
any customizability, which needs to be fixed.

The "slots" are defined in terms of what the color is used for, the
meaning, e.g. "a line from the file before the change (DIFF_FILE_OLD)";=
 we
cannot avoid having application specific set of slots, but the parsing
should be able to share the code.

Once the slot number is known, we ask color_parse() to put the final
physical string (suitable for the terminal's consumption) to fill the
slot.  But for that, I do not think git_color_codes[] nor GIT_COLOR_FOO
need to be exposed to the applications (i.e. "diff", "branch", "grep").
It is an implementation detail that color_parse() always uses ANSI esca=
pe
sequences right now, but we could encapsulate that in color.c and later
perhaps start looking up from the terminfo database, for example.

But that leaves the question of initialization.  I think it would give =
a
better abstraction if we changed the type of values stored in a
color-table like diff.c::diff_colors[] from physical string sent to the
terminal to a color name (your enum color_name).  Then the application
code can initialize their own color-table for each application-specific
slots with GIT_COLOR_NAME_RED, let the configuration mechanism to
customize it for the user.  The codepath that currently assume the colo=
r
table contains strings that can be sent to the terminal need to be
modified to ask color_code_to_terminal_string(GIT_COLOR_NAME_YELLOW) or
something.  Which means:

(1) Physical color representation should be known only to color.c.  I.e=
=2E

	#define GIT_COLOR_BOLD "\033[1m"

    does not belong to color.h (public header for application consumpti=
on)
    nor diff.c (application);

(2) Logical color name and the ways to convert it for terminal consumpt=
ion
    belongs to color.h.  I.e.

	enum color_name {
        	GIT_COLOR_NAME_YELLOW,
                ...
	}

    should go to color.h;

    color_fprintf() should be changed to take "enum color_name color"
    instead of "const char *color";

    We would need strbuf variant for callers that prepare the string in
    core before giving it to fprintf().

(3) "static const char *git_color_codes[]" would be an implementation
    detail of the current "ANSI-only" one, hidden inside color.c, for
    color_fprintf() and its strbuf cousin to look at.
