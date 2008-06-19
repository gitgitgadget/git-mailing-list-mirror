From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7502-commit.sh: test_must_fail doesn't work with	inline
 environment variables
Date: Thu, 19 Jun 2008 15:39:14 -0500
Message-ID: <eL0AGIYbdnvG_hyKGyAA6ogzMbixNrhYwemCgYnHo-tYJkBD8ad0kQ@cipher.nrlssc.navy.mil>
References: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil> <20080619173932.GA32593@glandium.org> <gASAIyn4TvarEmVo9rWtEKa6eROfKXwowHxH6j05FzPARJ-CDBCHLw@cipher.nrlssc.navy.mil> <7vd4mduv3t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Qw7-0000c0-H0
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYFSUj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 16:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbYFSUj6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:39:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54080 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbYFSUj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 16:39:57 -0400
Received: by mail.nrlssc.navy.mil id m5JKdEo6031036; Thu, 19 Jun 2008 15:39:15 -0500
In-Reply-To: <7vd4mduv3t.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Jun 2008 20:39:14.0714 (UTC) FILETIME=[898D37A0:01C8D24C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85525>


Junio C Hamano wrote:

> A Subshell?
> 
> @@ -212,6 +212,7 @@ test_expect_success 'do not fire
>  	# Must fail due to conflict
>  	test_must_fail git cherry-pick -n master &&
>  	echo "editor not started" >.git/result &&
> -	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
> +	( GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" && export GIT_EDITOR &&
> +	  test_must_fail git commit ) &&
>  	test "$(cat .git/result)" = "editor not started"
>  '

That works and it's better.

-brandon
