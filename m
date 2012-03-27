From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Merge-friendly text-based data storage
Date: Tue, 27 Mar 2012 15:01:37 +0200
Message-ID: <CAD77+gR=p+jhN5qNoRgjtQPHqgqrdtcSmqAy_4d0NUaqE6ZkVg@mail.gmail.com>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
 <4F718496.4030808@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 15:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCW2G-00033d-HK
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 15:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2C0NB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 09:01:59 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58320 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2C0NB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 09:01:59 -0400
Received: by lbbgm6 with SMTP id gm6so4749067lbb.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bUm1GWMMyMN+pXsSygRoNk3U6So+zPnl8MkWMFg6gMM=;
        b=UIWt8ioehXBBKQnVMlg2rvd4MLXOwT678ja3UNpVBrT5TR6klhqbDLGiIwzswgErVi
         RnQmUGe8DZzt4h9GIh3yMyu3IPtvrdnwmb4Pyo7edKzSDQxRcHEU2XPGRiDFWV1W0Oml
         OkbmTP+ubq0lODCwr3BzGJAjrNluSpVap8tPnGHbQy1ipMEFS4RtN5ZtYWrUbwDnTY9/
         sXmtKUzhh1wDOv8pWF56dtlff8YAWbCewtWxVNYtnF1PQVrSggLqH5HYc2wmXtXsFnro
         qGzBvmNRKQm/k0V4CNnN4RX9DzFOWlkIikUL1bffakB1wrSbIWlgCjvuVnVJ/jimVOeC
         GEuA==
Received: by 10.112.40.232 with SMTP id a8mr2102426lbl.81.1332853317473; Tue,
 27 Mar 2012 06:01:57 -0700 (PDT)
Received: by 10.112.99.233 with HTTP; Tue, 27 Mar 2012 06:01:37 -0700 (PDT)
In-Reply-To: <4F718496.4030808@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194043>

On Tue, Mar 27, 2012 at 11:12, Holger Hellmuth <hellmuth@ira.uka.de> wrote:

> I may be misunderstanding something, but lets assume you want to merge a
> file that has "version: 0" with one that has "version: 1" and their last
> common ancestor would have "version: 0" naturally. So the merge would not
> fail even though the file layout changes.

Ugh, I did not consider that. I can't come up with a way, other than a
custom merge driver, to prevent this. Am I correct?


> And there would be random merge failures with lines added at the same line
> number even if different.

Yes, I know. That was the main reason why I asked for merge-friendly
designs. I briefly considered union merges, but that's not a good idea
for obvious reasons.


> The normal merging in git isn't suited for this task, it has different
> objectives. Without a custom merge driver as Junio suggested

I more or less accepted that I will have to write one, eventually.


> the only way
> would be to store each data line in its own file. As you store file paths
> that would even fit, but I doubt it is what you had in mind

I considered this as well, but that's extremely expensive and wasteful.


-- 
Richard
