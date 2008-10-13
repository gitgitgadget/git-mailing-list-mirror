From: Brandon <siamesedream01@gmail.com>
Subject: Re: concerns about git
Date: Mon, 13 Oct 2008 15:51:25 -0400
Message-ID: <82c87da00810131251i52d10170h5c1991e2da0bd208@mail.gmail.com>
References: <19959918.post@talk.nabble.com> <20081013181941.GT4856@spearce.org>
	 <e1dab3980810131140p45c62e5cs690ac190eeacc38e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	deepwinter <deepwinter@winterroot.net>, git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpTT5-0003Sq-KG
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 21:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbYJMTv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 15:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYJMTv1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 15:51:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:65198 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbYJMTv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 15:51:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1999652rvb.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HthGBFoOPfVNhv54D8hNwZDOohVRh5kDQNsDqRU7oeQ=;
        b=BNunv+j6X/V4nF8kwJrhLEHJ8Wd2gxTsFtO9YgTW2HtUwucMTEDsQXsuU4PKqiKMgw
         xRemToama3AkcOt4N0t1cx4L8rtUNYhwLnhEvpkaEx5UJTvDIDY3qZfVVTCiGrsoOhjQ
         jV/i6jmYm4FRsYpIJ833243TWgjeZ9sPqaynA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u3jIKulxrMR8UIC3U3IeyBAxnIQ3Y0dRSSL+4Frw5q7sDsOY3JIdAddwEftQB9hPk4
         gMz/J0XKTMfRo51M3vUiYypAuWTDUDBfbqvVvCFrXgF9S/mAqODqAvZvKFwBsJju9Y/X
         PdZiSUULQf4osf6vIWrbQRGhFcLbTd71dsVBk=
Received: by 10.141.177.10 with SMTP id e10mr4144843rvp.112.1223927485903;
        Mon, 13 Oct 2008 12:51:25 -0700 (PDT)
Received: by 10.141.4.20 with HTTP; Mon, 13 Oct 2008 12:51:25 -0700 (PDT)
In-Reply-To: <e1dab3980810131140p45c62e5cs690ac190eeacc38e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98141>

You can use "git config core.worktree <location>" to create a ".git"
folder that manages a working copy in another location.

I know some of the GUI tools don't support this though so I would only
use it if truly necessary  . (For example a using git to manage a
mapped network drive, it would be faster to keep the ".git" folder on
the local harddrive)

More documentation here: http://www.kernel.org/pub/software/scm/git/docs/

On Mon, Oct 13, 2008 at 2:40 PM, David Tweed <david.tweed@gmail.com> wrote:
> On Mon, Oct 13, 2008 at 7:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>  # then every once in a while, or from a cron job
>>  $ git push --all backup
>>
>> Of course since Git is distributed you can you use this same approach
>> to make backups to other systems.  You can even edit the .git/config
>> to give the [remote "backup"] section more than one url line, so
>> that "git push --all backup" will send updated copies to multiple
>> locations at once.
>
> Another advantage of 'git push'ing to another repository (possibly via
> cron) as backup is that (for technical reasons) git push has to
> 'parse' the new changes to your repository in order to push, so it is
> likely to spot corruption (eg, dying disk) at that time and when you
> can decide what to do about it. (I have enough backups all over the
> place that I don't worry about not having a 'copy' of any stuff I care
> about, but that there'll be some fatal corruption I don't notice
> immediately that then gets propagated everywhere rendering them
> useless.)
>
> --
> cheers, dave tweed__________________________
> david.tweed@gmail.com
> Rm 124, School of Systems Engineering, University of Reading.
> "while having code so boring anyone can maintain it, use Python." --
> attempted insult seen on slashdot
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
