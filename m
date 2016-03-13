From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Sun, 13 Mar 2016 18:41:35 +0100
Message-ID: <CB4CAAEA-0036-483A-9F2C-89B95E04037E@gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com> <CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com> <CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com> <61210CAD-D3D2-40AC-88F9-02169619F5F6@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Mar 13 18:41:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afA1R-0002Ey-NJ
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 18:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbcCMRlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 13:41:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35594 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcCMRlk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2016 13:41:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id n205so11195809wmf.2
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2nmcCN6D6aqvRl2NhT3+MMGWSdMBgDyJK365Vn+VUR0=;
        b=fiYK438FLIgbI2cvAOZyq7xH6a9y7bRiR6JClTXPrkybFThhsZ65OugpWMN2xpHj4M
         YIg+XqZAFQIMfj6MELD+MpjBNst1SV48VRaAzt4RqyCrw9yeySyWMBd9Qu1bhDOun7O6
         LU4N4ZdA0O3GY0Po4ylJRQj2+Iyp3AVN798BRw+/OGXWEwXcRJEhiuTnNyU+d/blKyEg
         vh2wiTfs5YJZBd+xFclo45gKz2etjVqWeLLOfnmWgRDKRu5m4MegqfOdsYO71n6i9qft
         aDXn7uFxYREmtUASRxgrQgSwmfaNbBXahAuyK0NpI/4Re7mJ9hX5AqYo5/prAm2WWoKl
         SLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2nmcCN6D6aqvRl2NhT3+MMGWSdMBgDyJK365Vn+VUR0=;
        b=O8jQMNVgo450XbpfVr375WcJ0JTR9Rutrw3y3dyUWSQ0iqjYIchtieqxe9b28EX/Gn
         QGcjdburR3iWHpCKmJS4E/UHVVjAiME9xL7OB+adpDgjUdx13NZDy+R1INKZWa7tlleR
         FR53o+agZE9I+XkM0UP1jqbAqnfKbidLk0QEi/BBUCT6TxZhR4UQMgKNPFx0lYKlxTEa
         38THzabbfWfAy+egGyrhKsrEIU6150avR+KfPkyrPrNk1g5t1c6zbvdL82AkrzYOi8C6
         JlCeW1U+TPR34QKBuIA3w4ewmI35fvc5hw3IalY3XhUYHo7wn3x5hiWPmCqdske5QOdw
         kKUg==
X-Gm-Message-State: AD7BkJJgdnNQA/zsIpNgBuNfEu9CCjz+9JZFtz/aaqzXr1WsSbZgezyp2kMNhRTYC9E3EQ==
X-Received: by 10.28.21.14 with SMTP id 14mr13121463wmv.39.1457890899372;
        Sun, 13 Mar 2016 10:41:39 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA6B3.dip0.t-ipconnect.de. [80.139.166.179])
        by smtp.gmail.com with ESMTPSA id w133sm12414545wmd.3.2016.03.13.10.41.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Mar 2016 10:41:38 -0700 (PDT)
In-Reply-To: <61210CAD-D3D2-40AC-88F9-02169619F5F6@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288756>


On 02 Mar 2016, at 10:25, Lars Schneider <larsxschneider@gmail.com> wrote:

> 
>> On 02 Mar 2016, at 06:06, Luke Diamand <luke@diamand.org> wrote:
>> 
>> On 1 March 2016 at 19:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Mar 1, 2016 at 5:49 AM,  <larsxschneider@gmail.com> wrote:
>>>> Map a P4 user to a specific name and email address in Git with the
>>>> "git-p4.mapUser" config. The config value must be a string adhering
>>>> to the format "p4user = First Lastname <email@address.com>".
>>>> 
>>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>>> ---
>>>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>>>> +git-p4.mapUser::
>>>> +       Map a P4 user to a name and email address in Git. Use a string
>>>> +       with the following format to create a mapping:
>>>> ++
>>>> +-------------
>>>> +git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
>>>> +-------------
>>>> ++
>>>> +A mapping will override any user information from P4. Mappings for
>>>> +multiple P4 user can be defined.
>>> 
>>> Sorry for not paying closer attention the first time, but this needs
>>> to be repeated for each P4 user you want to map, right? One can
>>> imagine this quickly becoming painful if you have a lot of users to
>>> map. Have you considered modeling this after git-svn where you can set
>>> an "authors" file (and name the corresponding option --authors-file)?
>> 
>> For most authors it should just use the existing Perforce user
>> information. This is (I assume) just for the occasional exception
>> where Perforce has the wrong email address.
> I agree this is an occasional exception. I use it for users that have been deleted on the Perforce server.
> 
> @Eric: If a user wants to they could create a custom gitconfig and then use the config "include" mechanism to achieve a "authors" file kind of approach.
> 

Is the patch uninteresting for git-p4 as it handles only an occasional
exception or did the patch get lost in the noise? :-)

Thanks,
Lars
