From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: don't use pathinfo for global actions
Date: Wed, 7 Jan 2009 22:32:16 +0100
Message-ID: <cb7bb73a0901071332x1c07114cp2eefbc4490db1eb0@mail.gmail.com>
References: <1230896080-22801-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901061837.23637.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Devin Doucette" <devin@doucette.cc>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 22:33:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKg22-0005YM-Ka
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZAGVcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 16:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZAGVcT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 16:32:19 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:58904 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbZAGVcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 16:32:19 -0500
Received: by ewy10 with SMTP id 10so9278643ewy.13
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jAtvfzqzyFqzOWdT4D4ioDqIBgpOZtabryXbLIv7D5Y=;
        b=Dc6WTCSsudHb66NbtDe17q2DsPxUMKSyoSy8SWi2rP3txey7JirCem5E7qWznoXcZe
         f1xWTcmos5FAWpFg7vvepDS6wbXrZna2Ij6XTdKhaVBVSiSa/JRBmChPkJvcXvFwaItD
         fw6bwhyFs0QxZqnTcjDg7xUBbx6Tv4G2OYMj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aVPYLAWupUfC6ACOHxZwG4mcPhgkohseo7QtIb5jdcctUCnTt7X7/S/367i2t5Fk5a
         Mgozqahr00ZYq6YBNXIZ8xInupYQgRfIRb8kp15ThCEtGCUa0lRk+HZAWOae9RnW2Txw
         A4VvcSlFQPAHb9FHGlowbYxaiHK+7AtcM8q8w=
Received: by 10.210.120.7 with SMTP id s7mr27798021ebc.184.1231363936667;
        Wed, 07 Jan 2009 13:32:16 -0800 (PST)
Received: by 10.210.57.20 with HTTP; Wed, 7 Jan 2009 13:32:16 -0800 (PST)
In-Reply-To: <200901061837.23637.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104836>

On Tue, Jan 6, 2009 at 6:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 2 Jan 2009, Giuseppe Bilotta wrote:
>> Accepting global actions in use_pathinfo is not a very robust solution
>> due to possible present and future conflicts between project names and
>> global actions, therefore we just refuse to create PATH_INFO URLs when
>> the project is not defined.
>
> I think it is quite robust solution and it makes sense; we use
> shortcuts http://git.example.com for projects_list page, and
> http://git.example.com/path/to/repo.git for overview 'summary'
> action for a project, therefore pathinfo has to look like the
> following: http://git.example.com/repo/action/hash with "action"
> _after_ "project".  And there is also matter of backward compatibility
> of URL (URLs shouldn't break).
>
> Anyway, we have $home_link for default project_list page, which
> is path_info without project, and query without query string...

Today I had this idea: a possible way to have global actions into the
path would be to use an invalid project name, but I'm not sure if
there ARE invalid project names at all. Maybe using something very
abstruse such as _projects_ (underscore "projects" underscore) or even
just _ (underscore).

The only thing I can think of for which global actions in path WOULD
be interesting would be that project tag paths would become something
like http://git.example.com/_/tag/sometagname which can be tagged by
the rel-tag microformat http://microformats.org/wiki/rel-tag ...

-- 
Giuseppe "Oblomov" Bilotta
