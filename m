From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdiff: Show function names in hunk headers.
Date: Tue, 28 Mar 2006 01:50:10 -0800
Message-ID: <7vvetykiel.fsf@assigned-by-dhcp.cox.net>
References: <11435126113456-git-send-email-mdw@distorted.org.uk>
	<7vfyl3m7vy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 11:50:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOAq9-0001OZ-Np
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 11:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWC1JuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 04:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWC1JuN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 04:50:13 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42421 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932065AbWC1JuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 04:50:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328095011.DDC25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 04:50:11 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <7vfyl3m7vy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 27 Mar 2006 21:54:25 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18115>

Junio C Hamano <junkio@cox.net> writes:

> Mark Wooding <mdw@distorted.org.uk> writes:
>...
>> +		    (isalpha((unsigned char)*rec) || /* identifier? */
>> +		     *rec == '_' ||	/* also identifier? */
>> +		     *rec == '(' ||	/* lisp defun? */
>> +		     *rec == '#')) {	/* #define? */
>
> GNU diff -p does "^[[:alpha:]$_]"; personally I think any line
> that does not begin with a whitespace is good enough.

Obviously I was not thinking.  That should at least be "any line
that begins with a non-whitespace and has a few characters", to
omit "{\n" and catch "int main()\n" in:

	int main()
        {
        	printf("Hello, world.\n");
        }

;-).
