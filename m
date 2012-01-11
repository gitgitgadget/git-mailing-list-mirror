From: Soham Mehta <soham@box.com>
Subject: Re: Intriguing error with Git 1.6.3.1: Too many open files
Date: Tue, 10 Jan 2012 22:52:46 -0800
Message-ID: <CALjyegVzchN==DEsARD65jEmz0BkkbYMQRhG=ujNiGCBHuB4SQ@mail.gmail.com>
References: <CALjyegUJ+ZY7g0Lpxqs=gvAyhtYW_a3SNWVybSG4EG3X=ROV9Q@mail.gmail.com>
 <20120111030931.GA12862@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 07:53:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rks3g-0001ea-2l
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 07:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab2AKGxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 01:53:11 -0500
Received: from exprod6og107.obsmtp.com ([64.18.1.208]:43388 "HELO
	exprod6og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751418Ab2AKGxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 01:53:10 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]) (using TLSv1) by exprod6ob107.postini.com ([64.18.5.12]) with SMTP
	ID DSNKTw0x1KE2ElWCa+t3Th00BOJ/tHE78qxK@postini.com; Tue, 10 Jan 2012 22:53:09 PST
Received: by wibhn14 with SMTP id hn14so162744wib.11
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 22:53:07 -0800 (PST)
Received: by 10.180.77.228 with SMTP id v4mr39956762wiw.8.1326264787284; Tue,
 10 Jan 2012 22:53:07 -0800 (PST)
Received: by 10.223.116.145 with HTTP; Tue, 10 Jan 2012 22:52:46 -0800 (PST)
In-Reply-To: <20120111030931.GA12862@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188336>

On Tue, Jan 10, 2012 at 7:09 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Soham Mehta wrote:
>
>> *"error: unable to open object pack directory: ./objects/pack: Too many
>> open files"
>
> Do current git versions (v1.7.4.2 or later) behave the same way?
>
> Sorry for the trouble,
> Jonathan


I haven't played with versions yet. Are you alluding that #2 on this
list may have addressed it?
https://raw.github.com/gitster/git/master/Documentation/RelNotes/1.7.4.2.txt

 * We used to keep one file descriptor open for each and every packfile
   that we have a mmap window on it (read: "in use"), even when for very
   tiny packfiles.  We now close the file descriptor early when the entire
   packfile fits inside one mmap window.


The corrupt repo does have a 1000+ pack files, anywhere from 650M to 2.5K.
