From: Imre Simon <is@ime.usp.br>
Subject: A couple of questions
Date: Mon, 18 Apr 2005 08:51:00 -0300
Message-ID: <42639F24.90007@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 18 13:46:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNUhB-0002Wq-Qi
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 13:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVDRLti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 07:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVDRLti
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 07:49:38 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:53240 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262042AbVDRLtg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 07:49:36 -0400
Received: from [192.168.0.7] (201-1-102-93.dsl.telesp.net.br [201.1.102.93])
	by scorpion1.uol.com.br (Postfix) with ESMTP id 17FDB7EE9;
	Mon, 18 Apr 2005 08:49:31 -0300 (BRT)
User-Agent: Mozilla Thunderbird 1.0RC1 (Macintosh/20041201)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

How will git handle a corrupted (git) file system?

For instance, what can be done if objects/xy/z{38} does not pass the
simple consistency test, i.e. if the file's sha1 hash is not xyz{38}?
This might be a serious problem because, in general, one cannot
reconstruct the contents of file objects/xy/z{38} from its name
xyz{38}.

Another problem might come up if the file does pass the simple
consistency test but the file's contents is not a valid git file,
i.e. something that

  (*) successfully inflates to a stream of bytes that forms a sequence of
  <ascii tag without space> + <space> + <ascii decimal size> +
  <byte\0> + <binary object data>.

Are there enough internal redundancies in git to allow fixing at least
some corrupted file systems? Shouldn't there be some?

Another related observation is that git is not really based on a 160 bit
hashing scheme. Indeed, only files that satisfy the above condition
(*) are allowed and this most certainly reduces the valid range of the
hashing function. I do not think that this will be a problem, but it
doesn't hurt to point this out once.

Cheers,

Imre Simon

