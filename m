From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Tue, 4 Jul 2006 20:38:46 +0200
Message-ID: <e5bfff550607041138g60a82819lb5e59ea239b55ef5@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org> <e89iql$42a$1@sea.gmane.org>
	 <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	 <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
	 <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com>
	 <e8d2eo$k44$1@sea.gmane.org>
	 <e5bfff550607040458m1e6ea6bes44b3e3eba26856f0@mail.gmail.com>
	 <e8dqfo$3ff$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 04 20:38:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxpnP-0006eS-6U
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 20:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWGDSis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWGDSis
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 14:38:48 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:24566 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932330AbWGDSir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 14:38:47 -0400
Received: by py-out-1112.google.com with SMTP id t32so1936698pyc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 11:38:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XXturnl+6uNful5eFN/wn24xby8BNU3Is68wJXHRbDgeiUOF+W+eTR88u0J1TZsn3gDCv0u6dGE+Q2Js7LAWIOf8lX05r+BH/pkxaSnbBaA9NFnAXFlPrEMUipw5xo8DQ30ZTOovoCbE7oq7O98VkDQp+ln6kWhOGfwPq19P0t4=
Received: by 10.35.20.14 with SMTP id x14mr2504876pyi;
        Tue, 04 Jul 2006 11:38:46 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Tue, 4 Jul 2006 11:38:46 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e8dqfo$3ff$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23306>

On 7/4/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Marco Costalba wrote:
>
> >
> > Is this something that can fulfill you request? do you need something
> > different?  perhaps something as a "default to current selected SHA as
> > input argument" flag.
>
> It would be nice (I don't know if feasible) that either to provide some kind
> of parameters substitution in the likes of "%head" in the invocation line
> for a script to be expanded to the sha1 or name of head of currently
> selected commit.
>

Well, I think that the indiscussed champion in this field is git-rev-parse

Please note that an action have not to be _one_  git command, but you
can assign a command sequence to an action, if the first command is
git-rev-parse probably you have what you need.

I have to better explain some implemantation details. In case a multi
line text is set as an action content,  qgit wraps up the content in a
temporary script and run the script as a whole.
So you can use anything inside your action definition.

NOTE: this is possible because the input parameters are _always_
appended to the first line command only.

As example if the action 'test' is defined as:

echo
echo 2
echo 3

When you run 'test' and insert  '1'  when prompted for input
parameters the output will be:
1
2
3

Hope this helps.

    Marco
