From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Mon, 20 Oct 2008 16:43:51 +0200
Message-ID: <48FC9927.5030903@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu> <48FC55F9.3060509@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 20 18:56:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krw0N-0000vo-Es
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYJTOn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYJTOn7
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:43:59 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:40738 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750976AbYJTOn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:43:58 -0400
Received: (qmail 25805 invoked from network); 20 Oct 2008 14:43:55 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 20 Oct 2008 14:43:55 -0000
Received: (qmail 6771 invoked from network); 20 Oct 2008 14:43:51 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 20 Oct 2008 14:43:51 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48FC55F9.3060509@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98680>

Andreas Ericsson wrote:
> Christian Jaeger wrote:
>> If you really wanted, I suppose you could additionally look into 
>> implementing a kind of shallow cloning that only copies objects over 
>> the wire which are necessary for representing the subdirectory you're 
>> interested in.
>>
>
> So what do you do when one such commit also affects something outside
> the subdirectory?

You haven't said what you mean with "affect".

Since the point is that you do not want to see any effect to be made nor 
described if it is about something outside the subdirectory, the program 
would just not look at those?

Did you mean, new commits to be made from changed subdirectory contents? 
The stuff outside the subdirectory would just be kept the same and thus 
again doesn't need to be present locally.

Did you mean merging branches where one or more of the branches have 
changes outside the working directory? As long as the changes from the 
branches don't touch any of the same files (outside the 
subworkingdirectory), there's no need to fetch the files' contents, the 
program is only interested in the changes in the directory listings 
(thus directory objects). Now if there *are* changes to the same files 
(and outside the subworkingdirectory), the program would certainly need 
to fetch those contents, too, to be able to create the new contents. 
Would it require a place in the working directory? Yes if there are 
conflicts which need to be resolved manually, since it needs a place to 
put the conflicts to ask the user to resolve.  So I guess it boils down 
to SVN having a different notion of what a merge entails?

Christian.
