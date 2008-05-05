From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Add pre command argument to git submodule recurse subcommand
Date: Mon, 5 May 2008 15:07:42 +0600
Message-ID: <7bfdc29a0805050207n6d2f8122kbb58d8e5389d90eb@mail.gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-4-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswgS-0004BM-Rc
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbYEEJHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755062AbYEEJHo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:07:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60796 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbYEEJHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:07:43 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1026920nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aGR7xVlIQzpWR2/prc2MGACMgVI/zORd8d3TYzQI3wI=;
        b=m6Ct3ADl4k6zmidmtawRsgoQxRdKiK3d4+E35ki+kPsMh64rFSTcFglnpwj3/RSTjCGR04XGB6pAu+/Hooyhgefh7/tkVA2wmYysZ8Dvc2IwfZnPK8Qxno7VhgffHqmmQJddoBMKahCV+JtcxUG5fLwTviGWz2D3j35bjq/Ca+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cqf9qG1b39akvwL3urFA5eLvsxOl5P43BVqSAfka9bjuzL6gBrj+iI7BdTfupfpCp3rNKvtOW2vWFOwYveu49IKXH6HcnwNgZ2Q+AaK3cwZMQeWf2nLp5IbBxBAF5o9zALpmYQ1mqZLPESZ1VIWt1pBICS7l3V2wgl0h75zxMPk=
Received: by 10.78.136.9 with SMTP id j9mr1527301hud.67.1209978462815;
        Mon, 05 May 2008 02:07:42 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 5 May 2008 02:07:42 -0700 (PDT)
In-Reply-To: <1209977051-25896-4-git-send-email-imyousuf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81253>

Sorry for the inconvenience, but please ignore this patch as it was
not generated with -n and version number :(.

- best regards,

Imran


On Mon, May 5, 2008 at 2:44 PM,  <imyousuf@gmail.com> wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
>  I usually feel that when typing a command, being able to see some options
>  come in handy. For example if I can see the available branches before checking
>  out a branch that would be useful, IOW, if I could do 'git branch' before git
>  checkout it would be helpful.
>
>  It is now possible using the [-p|--pre-command] option. Using this
>  subcommand command argument one can actually execute another command before
>  specifying the arguments or the original command getting executed.
>
>         git submodule recurse -a -p checkout
>
>  it will prompt the user for the pre command until one is satisfied and later
>  the original command with the custom argument will get executed.
>
>  Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
>  ---
>   git-submodule.sh |   29 ++++++++++++++++++++++++++++-
>   1 files changed, 28 insertions(+), 1 deletions(-)
>
>  diff --git a/git-submodule.sh b/git-submodule.sh
>  index 314652d..dd80850 100755
>  --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -12,7 +12,7 @@ LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
>   $0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
>   $0 init|update [-q|--quiet] [--] [<path>...]
>   $0 summary [--cached] [-n|--summary-limit <n>] [<commit>]
>  -$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] [-a|--customized-argument] <git command> [<args> ...]"
>  +$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] [-a|--customized-argument] [-p|--pre-command] <git command> [<args> ...]"
>   OPTIONS_SPEC=
>   . git-sh-setup
>   require_work_tree
>  @@ -27,6 +27,7 @@ depth_first=1
>   on_error=
>   use_custom_args=
>   custom_args=
>  +pre_cmd=
>
>   #
>   # print stuff on stdout unless -q was specified
>  @@ -587,6 +588,28 @@ cmd_status()
>         done
>   }
>
>  +# Take command from user and execute it until user wants to discontinue
>  +do_pre_command()
>  +{
>  +       say "Starting pre-comamnd execution!"
>  +       while :
>  +       do
>  +               (
>  +                       printf "Please provide a command: "
>  +                       read pre_command
>  +                       test -z "$pre_command" ||
>  +                       eval "$pre_command"
>  +               )
>  +               printf "Press y to continue with another shell command... "
>  +               read keypress
>  +               if test "$keypress" != "y" &&
>  +                       test "$keypress" != "Y"
>  +               then
>  +                       break
>  +               fi
>  +       done
>  +}
>  +
>   # Take arguments from user to pass as custom arguments and execute the command
>   exec_with_custom_args()
>   {
>  @@ -673,6 +696,7 @@ traverse_module()
>                 # If depth-first is specified in that case submodules are
>                 # are traversed before executing the command on this submodule
>                 test -n "$depth_first" && traverse_submodules "$@"
>  +               test -n "$pre_cmd" && do_pre_command
>                 say "git submodule recurse $submod_path $*"
>                 if test -n "$use_custom_args"
>                 then
>  @@ -734,6 +758,9 @@ cmd_recurse() {
>                 -a|--customized-argument)
>                         use_custom_args=1
>                         ;;
>  +               -p|--pre-command)
>  +                       pre_cmd=1
>  +                       ;;
>                 -*)
>                         usage
>                         ;;
>  --
>  1.5.4.2
>
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
