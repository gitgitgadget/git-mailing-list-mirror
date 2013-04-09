From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Tue, 9 Apr 2013 12:31:49 -0400
Message-ID: <20130409163149.GA20752@pug.qqx.org>
References: <20130408185957.GM27178@pug.qqx.org>
 <1365461200-13509-1-git-send-email-aaron@schrab.com>
 <1365461200-13509-3-git-send-email-aaron@schrab.com>
 <20130409002456.GW30308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 18:31:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbSd-0003A1-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 18:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936864Ab3DIQbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 12:31:51 -0400
Received: from pug.qqx.org ([50.116.43.67]:38543 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934149Ab3DIQbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 12:31:51 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 1743C1D31B; Tue,  9 Apr 2013 12:31:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130409002456.GW30308@google.com>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220582>

At 17:24 -0700 08 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> +test_expect_success 'clone using repo with gitfile as a reference' '
>> +	git clone --separate-git-dir=L A M &&
>> +	git clone --reference=M A N &&
>
>What should happen if I pass --reference=M/.git?

That isn't supported and I wouldn't expect it to work.  The --reference 
option is documented as taking the location of a repository as the 
argument and I wouldn't consider a .git file to be a repository.  I also 
can't think of a reason that it would be very useful since it should be 
simple to just refer to the directory containing the .git file.  But if 
others disagree, I could be convinced to add support for that.

I also wouldn't consider it breakage if that use would start working, so 
I don't see a point in adding a test to check that that usage fails.

>> +	echo "$base_dir/L/objects" > expected &&
>
>The usual style in tests is to include no space after >redirection
>operators.

Fixed for the next version, pending further comments.
