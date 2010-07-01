From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Forcing CRLF for files in a directory
Date: Thu, 1 Jul 2010 15:55:00 +0200
Message-ID: <20100701135500.GA20015@pvv.org>
References: <4C2C8644.4060208@ryanmccue.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan McCue <me@ryanmccue.info>
X-From: git-owner@vger.kernel.org Thu Jul 01 15:55:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUKES-00042Q-Po
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 15:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab0GANzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 09:55:04 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:40758 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab0GANzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 09:55:01 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OUKEG-0000A9-9o; Thu, 01 Jul 2010 15:55:00 +0200
Content-Disposition: inline
In-Reply-To: <4C2C8644.4060208@ryanmccue.info>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150037>

On Thu, Jul 01, 2010 at 10:12:52PM +1000, Ryan McCue wrote:
> Hi there,
>
> I'm working on a project at the moment which stores raw HTTP header data  
> along with bodies for use during testing. As each header line must be  
> separated by a CRLF, these need to remain so in the repository.
>
> My question is: Do I need to do anything special to ensure these CRLFs  
> aren't converted to LFs during checkout?

If you are working on Windows and have set autocrlf (default on in
msysgit), they will be converted to LF only in the repo if they are
auto-detected as text files, and will get LF when checked out on a
system with autocrlf false.

You can force autocrlf to not think of a file as a text file by
setting "-crlf" for that file in .gitattributes.

In the upcoming 1.7.2 release, autocrlf has been fixed to never
autodetect files with mixed line endings in the repository as text
files, but it will take considerable time before that version is used
everywhere I guess. Also, this won't really help you if you create the
files on Windows.

- Finn Arne
