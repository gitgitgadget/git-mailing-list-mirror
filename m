From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 00:47:05 +0100
Message-ID: <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <op.uo9hiqqqa8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tilo Schwarz <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqj7-0002cL-QF
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbZBOXrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbZBOXrI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:47:08 -0500
Received: from mail-fx0-f25.google.com ([209.85.220.25]:56936 "EHLO
	mail-fx0-f25.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbZBOXrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:47:07 -0500
Received: by fxm6 with SMTP id 6so1342257fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x48l2WQpOwGAwCIRlA0rG7jZ+r064j6izewU2ihslEU=;
        b=lU66+o2lyR5FmI8BsCOBo4JZeTbUxX9guNB0FTPE0/9HbDA6YsC0CX0fBzIyKzs2My
         oGUJM4761yZ3QReohR7knSq+/DgQnyK/8bCURlJXQluJP1amLuvTGQlmkMX3L8ntQKWW
         O22afegIe8alHFfIxlUNNI5eWc+UW2xdyzIfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G+/oyvOAPzh0JuIQYWtVSuUxr5NggXfqgYZmWmrlccBZO5hBx8Ez484fKZCkgRC8eE
         kWja922ZReQaXCHLQ25p+j+LqiELYUbxcwnGB5+1nARV4/qCZg35Wv9vDbHE8OHKGxmg
         fFf5xBFXDLggZsVVg4i7vY9zu2AD179Bk2Gcc=
Received: by 10.181.155.9 with SMTP id h9mr179374bko.176.1234741626024; Sun, 
	15 Feb 2009 15:47:06 -0800 (PST)
In-Reply-To: <op.uo9hiqqqa8ed4e@dellschleppa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110093>

On Fri, Feb 13, 2009 at 00:14, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
> Then I have another question: Did you ever thought of a branch view, where
> you can see, create, delete and merge the different branches which are in a
> git project.

I have thought about it. The question is if a separate view is
necessary or if the main view would do. For example, I sometimes use
gitk when I need to rename branches or prepare for rebasing a
patchset. One idea I would like to explore is to provide a compressed
version of the main view, where "intermediate" commits are hidden,
this way you could easily get a view of the relationship between
branches.

The simplest thing to make it easier to experiment with new features
would probably be to introduce a new external command specifier:
%(prompt:<msg>), possibly with some regex for validation. Then you
could add in your ~/.tigrc:

bind main A !git branch %(prompt:^wip/[a-z-]+$:Name) %(commit)

-- 
Jonas Fonseca
