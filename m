From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Sat, 5 May 2007 03:06:31 +0200
Message-ID: <200705050306.32345.jnareb@gmail.com>
References: <463ADE51.2030108@gmail.com> <7vy7k4p24s.fsf@assigned-by-dhcp.cox.net> <56b7f5510705041752o74b59284x872480e4413f83ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 03:06:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk8jT-00032O-6E
	for gcvg-git@gmane.org; Sat, 05 May 2007 03:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031058AbXEEBGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 21:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030865AbXEEBGk
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 21:06:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:58236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031058AbXEEBGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 21:06:39 -0400
Received: by ug-out-1314.google.com with SMTP id 44so744927uga
        for <git@vger.kernel.org>; Fri, 04 May 2007 18:06:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cP33Mf9YpI0087YdLqOKCGAiQdUkQam+M0lz0BwhDKftCOIZo8EVkEKEwM7gShafFE+DE1zi0a9EtBhTCE4GR74e1pkyhslIPJu/g+8M4zdvOz57ynYxMco5PTNO8VOy4N3Yks01wO5wJ0tFMzNcEYrtlfEFWUY34/i4htgEqvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eBSRl/eJQmcYvRZ85c80Klk1F2oGpRFwiHptlA2/wYfTEaneFk1PYBfO/oq1t7d0p9poeRd/VIvNW2z8x16RI0ENakrutuT5aLTv1f+bS8dC5QlyJ08Qwuml+fdopj0jXDBYs07drHJ45RRepQKK5BN8QwMRK7j7p1CbtRUWgbE=
Received: by 10.66.218.15 with SMTP id q15mr3094444ugg.1178327198174;
        Fri, 04 May 2007 18:06:38 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id q1sm6480324uge.2007.05.04.18.06.36;
        Fri, 04 May 2007 18:06:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <56b7f5510705041752o74b59284x872480e4413f83ab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46234>

Dana How wrote:
> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:

>>> I'm not sure about "<tree-ish>:<path>" with <path> being relative by
>>> default. For me it is <path> in <tree-ish> (like in
>>> "git-ls-tree -r <tree-ish>" result).
>>
>> That's right (and Dscho is also).
>>
>> "v1.5.1:git.c" IS "git.c that appears at the toplevel of
>> v1.5.1's tree."
>>
>> Ok, for now let's forget about this relative stuff.
> 
> Hmm, most of the work I do in the parts of our
> perforce repository I want to convert to git is
> far enough down that the paths have 6 in-repo path components.
> I don't want to type all those when I want to fetch an
> older version with git-show.  Everything I do is relative.
> In fact,  I think perforce supports typing absolute paths,
> (using an 8-character prefix!) but I have never used it,
> nor would I if it were shorter.

I think the consensus is to use <tree-ish>:./<relative-path> for 
relative paths, and <tree-ish>:<path> for absolute (well, in the 
meaning that it counts from top of _tree-ish_, and tree-ish needs
not to be top tree / commit tree).

And I think 6 in-repo path components means not very well thought 
directory hierarchy, I think...

-- 
Jakub Narebski
Poland
