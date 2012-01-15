From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Sun, 15 Jan 2012 09:14:08 +0100
Message-ID: <4F128AD0.5020101@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1h?= =?UTF-8?B?cnTDrW4gTmlldG8=?= 
	<cmn@elego.de>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jan 15 09:14:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmLEe-0002xw-E1
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 09:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab2AOIOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 03:14:14 -0500
Received: from dotforward.de ([178.63.102.138]:58366 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab2AOION (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 03:14:13 -0500
Received: from dsl01.83.171.173.58.ip-pool.nefkom.net ([83.171.173.58] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1RmLE9-0000FS-HX; Sun, 15 Jan 2012 09:14:09 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F1085EC.9010708@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188590>

On 13.01.2012 20:28 CE(S)T, Holger Hellmuth wrote:
> Is it possible that Visual Studio changes them while you are comitting?

No. Those files may only be modified while open.

>> I renamed the file and created a new one with the same name. Is it so
>> simple to crash the Git repository?
> 
> Who said anything about crash? git simply doesn't care whether a change 
> is because of a rename. It isn't special or different to any change you 
> can make to a file

Well, there is a tracked file about which Git says it's untracked. How
would you describe such internal inconsistency? Maybe corruption would
fit better.

> As an aside, if .Designer.cs is generated automatically from Form1.cs it 
> shouldn't be tracked at all.

Of course, it's important! The file contains everything I draw in the UI
designer. I just don't write that myself which is why I rarely see its
contents.

> Maybe tortoise git has a global gitignore 
> with a line "*.Designer.cs" in it to account for that fact. Maybe this 
> lead to the error message?

It hasn't. This is already triple-checked by now. The file really is
definitely not ignored by any of the both ignore/exclude files known to me.

>>> What does git diff -- Form1.Designer.cs' say?
>> Nothing.
>>
>>> What does 'git diff form-refactoring -- Form1.Designer.cs' say?
>> All lines deleted.
> 
> Really all lines?

I don't have the time to re-check right now, but I remember seeing a
valid file beginning and end and no gaps in between. So I think it was
all files.

> That would indicate that you don't have a file 
> Form1.Designer.cs (or an empty one) in your working directory in branch 
> master. In case there is no file (as seen by git) the output of diff 
> should compare with /dev/null aka the void aka <I don't know how this 
> prints on the windows side>. Also notice the line "deleted file mode ..."
> 
>  > git diff master -- zumf
> diff --git a/zumf b/zumf
> deleted file mode 100644
> index 925eccd..0000000
> --- a/zumf
> +++ /dev/null
> @@ -1 +0,0 @@
> 
> Or did you just mean "all the shown lines in the diff were fronted by a 
> minus sign"?

Yes, and in dark red.

> Which would just indicate that the file in form-refactoring 
> is a superset of the one in master.
> 
> (As you can see, actual reproduction of command line output is very 
> helpful to avoid ambiguity and can give further hints)

That was some kind of less display. I could have attached a screenshot
to show it. It's not common or especially simple to include console
output on Windows, as there often is no console at all.

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
