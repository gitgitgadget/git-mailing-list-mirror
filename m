From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 02:01:49 -0700
Message-ID: <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
References: <4283CAF8.3050304@dgreaves.com>
	<20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 11:01:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWsWu-0001Zw-EM
	for gcvg-git@gmane.org; Sat, 14 May 2005 11:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVENJBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 05:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVENJBw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 05:01:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:50144 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262711AbVENJBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 05:01:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514090150.WXTT7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 05:01:50 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <4285B6A8.4080309@dgreaves.com> (David Greaves's message of
 "Sat, 14 May 2005 09:28:24 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

>>> if [[ $file =~ $patt ]]; then
>> 
>> I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
DG> OK
DG> I don't know how to do that.

Is that regexp or shell glob?  If regexp, expr is your friend,
like this:

    if expr "$file" : "$patt" >/dev/null; then

For a glob:

    patt='?.sh'
    file=1.sh

    case "$file" in
    $patt)
            echo Yeah ;;
    *)
            echo No ;;
    esac

