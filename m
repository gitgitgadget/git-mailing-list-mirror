From: "James Sadler" <freshtonic@gmail.com>
Subject: Re: how do i re-add a file?
Date: Tue, 1 Apr 2008 22:41:23 +1100
Message-ID: <e5e204700804010441r61d365d6se0f58c2f49d3058@mail.gmail.com>
References: <47F21814.6000705@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:42:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgesl-0002l1-1l
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759027AbYDALl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758298AbYDALl0
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:41:26 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:8843 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758940AbYDALlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:41:25 -0400
Received: by el-out-1112.google.com with SMTP id v27so778365ele.17
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=f+H2qo+N/Gj8fG5BjaIFd9T0w4WX1qDWz8PIFxb+/UU=;
        b=MFoQyQNkLjWdiNMTAPE2Llw5UuONw4oonHVKjvp7z4b91rcHX2TMIExsAUOsPT2CqxUT+ctUblDTl42ulmGxjKrGfVT0W0BDjMBarUmjotA7dr42veo8vAqfga48KvqbtJYSO5g+5AbLfYHEhcpENh/M3qAmy4khGBAwZ4eTUCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YRZoRpbAiEsnj0h8p8+mPy/6842/tx/xZGS5083jFUf/2iAK3MdpEOgWnjOEW6WIXQrWuevJI6wtJBLjXxdYgSY1jbnIM74D5ijN7lMvWm2TP+v2mFLqlBI82GGOAoKhRcAuMcJfI9L83NjGHc+QQISzOxt9n1i2mV+DiXvsHWI=
Received: by 10.115.75.1 with SMTP id c1mr12147414wal.84.1207050083579;
        Tue, 01 Apr 2008 04:41:23 -0700 (PDT)
Received: by 10.114.254.7 with HTTP; Tue, 1 Apr 2008 04:41:23 -0700 (PDT)
In-Reply-To: <47F21814.6000705@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78651>

There are at least a couple of ways to do this.

git show <revision>:<file_name>

e.g. git show HEAD^:builtin-log.c

That will output the content to the console of the file
'builtin-log.c' at the parent revision of the current commit.   You
can redirect it to a file if you want.

git checkout <rev> <file_name>

e.g. git checkout HEAD^ builtin-log.c

Works the same as above, except the file will be written to your
working tree without you having to redirect the output to a file.

Take a look at the help for 'checkout' and 'show'. (e.g. git checkout --help )

In the above examples, 'HEAD^' is just a shortcut for specifying a
revision without entering the entire SHA1 of the commit.  See
http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html for
more information on the various ways you can specify revisions.

Another way to look at file content at a particular revision is via
the 'gitk' GUI tool that comes with git.  Fire it up by entering
'gitk' at the command line while inside your repo.  In the pane on the
left, select the revision that you are interested in.  On the
bottom-right pane, select the radio button labeled 'tree' and navigate
through that to find you file.  When you select it, the content of the
file will be displayed on the bottom-left pane.

-- 

James.

On 01/04/2008, Ittay Dror <ittayd@tikalk.com> wrote:
> I did git-rm on a file and committed. Made some changes to my sources
>  and committed. Now I want the file back. How can I do that? Related to
>  that, how do I revert my files to some past commit state so that the
>  commits in between are kept in the history?
>
>  Thank you,
>  Ittay
>
>  --
>  Ittay Dror <ittayd@tikalk.com>
>  Tikal <http://www.tikalk.com>
>  Tikal Project <http://tikal.sourceforge.net>
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
James
